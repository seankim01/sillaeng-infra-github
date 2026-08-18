# Local values for health check protocol determination
locals {
  tg_health_check_protocols = {
    for tg in var.tg_create : tg.index => (
      lookup(tg, "target_type", "instance") == "alb" ? (
        tg.port == 443 ? "HTTPS" : "HTTP"
      ) : (
        lookup(tg, "health_check", null) != null ? lookup(tg.health_check, "protocol", null) : lookup(tg, "health_check_protocol", null)
      ) != null ? upper(
        lookup(tg, "health_check", null) != null ? lookup(tg.health_check, "protocol", null) : lookup(tg, "health_check_protocol", null)
      ) : upper(tg.protocol)
    )
  }
  tg_is_tcp_protocol = {
    for tg in var.tg_create : tg.index => (
      lookup(tg, "target_type", "instance") == "alb" ? false : contains(["TCP", "TCP_UDP", "TLS", "UDP"], local.tg_health_check_protocols[tg.index])
    )
  }
}

resource "aws_lb" "this" {
  for_each           = { for _map in var.lb_create : _map.index => _map }
  name               = join("-", [var.company, var.env, each.value.name])
  internal           = each.value.internal
  load_balancer_type = each.value.load_balancer_type
  security_groups    = [for sg_ids in each.value.sg_index : var.sg_info[sg_ids].id]
  subnets            = [for subnet_ids in each.value.sub_index : var.subnet_info[subnet_ids].id]

  idle_timeout                     = lookup(each.value, "idle_timeout", 60)
  enable_deletion_protection       = lookup(each.value, "enable_deletion_protection", false)
  client_keep_alive                = lookup(each.value, "client_keep_alive", 3600)
  drop_invalid_header_fields       = lookup(each.value, "drop_invalid_header_fields", false) # only application
  enable_cross_zone_load_balancing = lookup(each.value, "enable_cross_zone_load_balancing", false)
  enable_http2                     = lookup(each.value, "enable_http2", true)
  ip_address_type                  = lookup(each.value, "ip_address_type", "ipv4")
  preserve_host_header             = lookup(each.value, "preserve_host_header", false)

  # 사용시 주석제거 
  # connection_logs {
  #   bucket  = lookup(each.value, "connection_logs_bucket", null)
  #   prefix  = lookup(each.value, "connection_logs_prefix", null)
  #   enabled = lookup(each.value, "connection_logs_enabled", false)
  # }

  # access_logs {
  #   bucket  = lookup(each.value, "access_logs_bucket", null)
  #   prefix  = lookup(each.value, "access_logs_prefix", null)
  #   enabled = lookup(each.value, "access_logs_enabled", false)
  # }

  dynamic "subnet_mapping" {
    for_each = try(each.value.subnet_mapping, [])
    iterator = sbn

    content {
      subnet_id            = try(var.subnet_info[sbn.value.subnet].id, null)
      allocation_id        = try(var.vpc_info[sbn.value.allocation_id].id, null) # 생성한 eip가 없다면 AWS에서 자동 할당
      private_ipv4_address = lookup(sbn.value, "private_ipv4_address", null)
      ipv6_address         = lookup(sbn.value, "ipv6_address", null)
    }
  }

  depends_on = [aws_lb_target_group.this]

  tags = merge(
    lookup(each.value, "custom_tags", null),
    {
      Env = var.env
      Name = join("-",
        [var.company,
          var.env,
          each.value.name
      ])
  })
}


resource "aws_lb_listener" "this" {
  for_each = { for _map in var.lb_listener_create : _map.index => _map }

  load_balancer_arn = aws_lb.this[each.value.lb_index].arn
  port              = each.value.port
  protocol          = upper(each.value.protocol)

  ssl_policy      = try(each.value.ssl_policy, null)
  certificate_arn = lookup(each.value, "certificate_arn", null)

  default_action {
    type             = each.value.action
    target_group_arn = each.value.action == "forward" ? try(aws_lb_target_group.this[each.value.target].arn, null) : null

    dynamic "redirect" {
      for_each = lookup(each.value, "action", null) == "redirect" ? [lookup(each.value, "redirect", {})] : []

      content {
        port        = lookup(redirect.value, "port", null)
        protocol    = lookup(redirect.value, "protocol", null)
        status_code = lookup(redirect.value, "status_code", null)
      }
    }

    dynamic "fixed_response" {
      for_each = lookup(each.value, "action", null) == "fixed-response" ? [lookup(each.value, "fixed_response", {})] : []

      content {
        content_type = lookup(fixed_response.value, "content_type", null)
        message_body = lookup(fixed_response.value, "message_body", null)
        status_code  = lookup(fixed_response.value, "status_code", null)
      }
    }
  }

  depends_on = [
    aws_lb.this,
    aws_lb_target_group.this,
    # Ensure target group attachments are removed before listener deletion
    # This prevents "ResourceInUse" errors when destroying
    aws_lb_target_group_attachment.alb,
    aws_lb_target_group_attachment.ec2,
  ]

  lifecycle {
    create_before_destroy = false
  }
}


resource "aws_lb_listener_rule" "this" {
  for_each = { for _rule in var.lb_listener_rules_create : join("-", [_rule.listener, _rule.priority]) => _rule }

  listener_arn = aws_lb_listener.this[each.value.listener].arn
  priority     = each.value.priority

  tags = {
    Name = lookup(each.value, "name", null)
  }

  dynamic "action" {
    for_each = lookup(each.value, "action", null) == "forward" ? [lookup(each.value, "forward", {})] : []

    content {
      type             = each.value["action"]
      target_group_arn = aws_lb_target_group.this[each.value["target"]].arn
    }
  }

  dynamic "condition" {
    for_each = [
      for condition_rule in each.value["conditions"] : condition_rule
      if lookup(condition_rule, "host_headers", null) != null
    ]

    content {
      host_header {
        values = condition.value["host_headers"]
      }
    }
  }

  dynamic "condition" {
    for_each = [
      for condition_rule in each.value["conditions"] : condition_rule
      if lookup(condition_rule, "path_patterns", null) != null
    ]

    content {
      path_pattern {
        values = condition.value["path_patterns"]
      }
    }
  }
}


resource "aws_lb_target_group" "this" {
  for_each = { for _map in var.tg_create : _map.index => _map }
  name     = join("-", [var.company, var.env, each.value.name])
  port     = each.value.port
  protocol = each.value.protocol
  vpc_id   = [for vpc_id in [each.value.vpc_index] : var.vpc_info[vpc_id].id][0]

  target_type                   = lookup(each.value, "target_type", "instance")
  deregistration_delay          = lookup(each.value, "deregistration_delay", "300")
  load_balancing_algorithm_type = lookup(each.value, "load_balancing_algorithm_type", "round_robin")
  slow_start                    = lookup(each.value, "slow_start", null)
  proxy_protocol_v2             = lookup(each.value, "proxy_protocol_v2", false)
  ip_address_type               = lookup(each.value, "ip_address_type", "ipv4")

  health_check {
    enabled             = lookup(each.value, "health_check", null) != null ? lookup(each.value.health_check, "enabled", true) : lookup(each.value, "health_check_enabled", true)
    interval            = lookup(each.value, "health_check", null) != null ? lookup(each.value.health_check, "interval", 30) : lookup(each.value, "health_check_interval", 30)
    timeout             = lookup(each.value, "health_check", null) != null ? lookup(each.value.health_check, "timeout", 10) : lookup(each.value, "timeout", 10)
    healthy_threshold   = lookup(each.value, "health_check", null) != null ? lookup(each.value.health_check, "healthy_threshold", 3) : lookup(each.value, "healthy_threshold", 3)
    unhealthy_threshold = lookup(each.value, "health_check", null) != null ? lookup(each.value.health_check, "unhealthy_threshold", 3) : lookup(each.value, "unhealthy_threshold", 3)
    port                = lookup(each.value, "health_check", null) != null ? lookup(each.value.health_check, "port", "traffic-port") : lookup(each.value, "health_check_port", "traffic-port")
    # When target_type is "alb", health check protocol must be HTTP or HTTPS, not TCP
    protocol            = lookup(each.value, "target_type", "instance") == "alb" ? (
      each.value.port == 443 ? "HTTPS" : "HTTP"
    ) : (
      lookup(each.value, "health_check", null) != null ? lookup(each.value.health_check, "protocol", null) : lookup(each.value, "health_check_protocol", null)
    )
    
    # path and matcher are only valid for HTTP/HTTPS health checks, not for TCP/UDP/TLS
    # Use locals to determine if protocol is TCP-based
    path    = local.tg_is_tcp_protocol[each.value.index] ? null : (lookup(each.value, "health_check", null) != null ? lookup(each.value.health_check, "path", "/") : lookup(each.value, "path", "/"))
    matcher = local.tg_is_tcp_protocol[each.value.index] ? null : (lookup(each.value, "health_check", null) != null ? lookup(each.value.health_check, "matcher", "200") : lookup(each.value, "matcher", "200"))
  }
  stickiness {
    cookie_duration = lookup(each.value, "cookie_duration", 86400)
    cookie_name     = lookup(each.value, "cookie_name", null)
    enabled         = lookup(each.value, "stickiness_enabled", true)
    type            = lookup(each.value, "stickiness_type", "lb_cookie") # ALB : lb_cookie, app_cookie / NLB : source_ip / GWLB : source_ip_dest_ip, source_ip_dest_ip_proto
  }
  target_group_health {
    dns_failover {
      minimum_healthy_targets_count      = lookup(each.value, "minimum_healthy_targets_count", "off")
      minimum_healthy_targets_percentage = lookup(each.value, "minimum_healthy_targets_percentage", "off")
    }
    unhealthy_state_routing {
      minimum_healthy_targets_count      = lookup(each.value, "minimum_healthy_targets_count", 1)
      minimum_healthy_targets_percentage = lookup(each.value, "minimum_healthy_targets_percentage", "off")
    }
  }
  #  GWLB 사용 시 주석 해제
  # target_failover {
  #   on_deregistration = lookup(each.value, "on_deregistration", "no_rebalance")
  #   on_unhealthy      = lookup(each.value, "on_unhealthy", "no_rebalance")
  # }

  #  NLB 사용 시 주석 해제
  # target_health_state {
  #   enable_unhealthy_connection_termination = lookup(each.value, "enable_unhealthy_connection_termination", true)
  # }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    lookup(each.value, "custom_tags", null),
    {
      Env = var.env
      Name = join("-",
        [var.company,
          var.env,
          each.value.name,
          each.value.port
      ])
  })
}

# Target Group Attach - ec2
resource "aws_lb_target_group_attachment" "ec2" {
  for_each = merge(
    flatten([
      for _map in var.tg_create : {
        for ec2 in _map.target_id :
        join("-", [_map.name, _map.port, ec2]) => merge(_map, { target = ec2 })
      } if length(lookup(_map, "target_id", "")) > 0
    ])
  ...)

  target_group_arn = aws_lb_target_group.this[each.value.index].arn
  target_id        = var.ec2_info[each.value.target].id
  port             = each.value.port

  depends_on = [aws_lb_target_group.this]
}

# Target Group Attach - alb (for NLB to ALB connection)
resource "aws_lb_target_group_attachment" "alb" {
  for_each = merge(
    flatten([
      for _map in var.tg_create : {
        for alb in lookup(_map, "target_lb", []) :
        join("-", [_map.index, alb]) => merge(_map, { target = alb })
      } if length(lookup(_map, "target_lb", [])) > 0
    ])
  ...)

  target_group_arn = aws_lb_target_group.this[each.value.index].arn
  target_id        = aws_lb.this[each.value.target].arn
  port             = each.value.port

  depends_on = [
    aws_lb_target_group.this,
    aws_lb.this
  ]

  lifecycle {
    create_before_destroy = false
  }
}


