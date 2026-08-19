lb_create = [
  {
    index                      = "ext-service-alb-01"
    name                       = "service-alb-ext"
    internal                   = false
    load_balancer_type         = "application"
    sg_index                   = ["service-pub-alb"]
    sub_index                  = ["service-pub-01a", "service-pub-02c"]
    enable_deletion_protection = false
  },
]

lb_listener_create = [
  {
    index    = "ext-service-alb-80"
    lb_index = "ext-service-alb-01"
    port     = "80"
    protocol = "HTTP"

    action = "forward"
    target = "tg-dev"
  },
]

lb_listener_rules_create = []

tg_create = [
  {
    index     = "tg-dev"
    name      = "tg-dev"
    vpc_index = "sillaeng-demo-service-vpc"
    port      = 80
    protocol  = "HTTP"
    target_id = ["service-ec2-dev-01a"]

    health_check = {
      enabled             = true
      interval            = 30
      path                = "/"
      timeout             = 10
      matcher             = "200-399"
      healthy_threshold   = 3
      unhealthy_threshold = 3
      port                = "traffic-port"
      protocol            = null
    }
  },
]
