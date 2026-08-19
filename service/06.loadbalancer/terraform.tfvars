lb_create = [
  {
    index                      = "ext-stadium-alb-01"
    name                       = "stadium-alb-ext"
    internal                   = false
    load_balancer_type         = "application"
    sg_index                   = ["ext-stadium-alb"]
    sub_index                  = ["service-pub-01a", "service-pub-02c"]
    enable_deletion_protection = false
  },
  {
    index                      = "ext-runner-alb-01"
    name                       = "runner-alb-ext"
    internal                   = false
    load_balancer_type         = "application"
    sg_index                   = ["ext-runner-alb"]
    sub_index                  = ["service-pub-01a", "service-pub-02c"]
    enable_deletion_protection = false
  },  
  {
    index                      = "ext-runner-nlb-01"
    name                       = "runner-nlb-ext"
    internal                   = false
    load_balancer_type         = "network"
    sg_index                   = ["ext-runner-nlb"]
    sub_index                  = ["service-pub-01a", "service-pub-02c"]
    enable_deletion_protection = false
  },    
]
lb_listener_create = [
  {
    index    = "ext-stadium-alb-80"
    lb_index = "ext-stadium-alb-01"
    port     = "80"
    protocol = "HTTP"

    action = "redirect"

    redirect = {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  },
  {
    index        = "ext-stadium-alb-443"
    lb_index     = "ext-stadium-alb-01"
    port         = "443"
    protocol     = "HTTPS"
    acm_required = true

    ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
    certificate_arn = "arn:aws:acm:ap-northeast-2:940482424078:certificate/e7dd69cc-c66f-4f08-89ce-557ec6c7f999"   # 신규(25년10월30일) 변경 필요    

    action = "forward"
    target = "tg-stadium"

  },

  {
    index    = "ext-runner-alb-80"
    lb_index = "ext-runner-alb-01"
    port     = "80"
    protocol = "HTTP"

    action = "redirect"

    redirect = {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  },
  {
    index        = "ext-runner-alb-443"
    lb_index     = "ext-runner-alb-01"
    port         = "443"
    protocol     = "HTTPS"
    acm_required = true

    ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
    certificate_arn = "arn:aws:acm:ap-northeast-2:940482424078:certificate/e7dd69cc-c66f-4f08-89ce-557ec6c7f999"   # 신규(25년10월30일) 변경 필요    

    action = "forward"
    target = "tg-runner"

  },
  # NLB Listener for connecting to ALB
  {
    index    = "ext-runner-nlb-443"
    lb_index = "ext-runner-nlb-01"
    port     = "443"
    protocol = "TCP"

    action = "forward"
    target = "tg-runner-nlb"
  },
]
lb_listener_rules_create = [
  {
    listener = "ext-stadium-alb-443"
    name     = "stadium"
    priority = 1

    action = "forward"
    target = "tg-stadium"

    conditions = [{
      host_headers = ["stadium.airbss.shop"]     # 신규(25년10월30일) 변경 필요   
      },
      # {
      #   path_patterns = ["/stadium/*"]
      # }
    ]
  },

  {
    listener = "ext-runner-alb-443"
    name     = "runner"
    priority = 1

    action = "forward"
    target = "tg-runner"

    conditions = [{
      host_headers = ["runner.airbss.shop"]     # 신규(25년10월30일) 변경 필요   
      },
      # {
      #   path_patterns = ["/runner/*"]
      # }
    ]
  },


]
tg_create = [
  {
    index     = "tg-stadium"
    name      = "tg-stadium"
    vpc_index = "sillaeng-demo-service-vpc"
    port      = 80
    protocol  = "HTTP"
    target_id = ["ec2-stadium0001", "ec2-stadium0002"]

    # Health check configuration
    # All fields are optional, defaults will be used if not specified
    health_check = {
      enabled             = true                    # Enable or disable health checks (default: true)
      interval            = 30                      # Health check interval in seconds (default: 30)
      path                = "/"                     # Health check path (default: "/")
      timeout             = 10                      # Health check timeout in seconds (default: 10)
      matcher             = "200-399"                    # HTTP status codes to consider healthy (default: "200")
      healthy_threshold   = 3                       # Number of consecutive successful checks (default: 3)
      unhealthy_threshold = 3                       # Number of consecutive failed checks (default: 3)
      port                = "traffic-port"          # Health check port: "traffic-port" or specific port number (default: "traffic-port")
      protocol            = null                    # Health check protocol: "HTTP", "HTTPS", "TCP", "TCP_UDP", "TLS", "UDP", "GENEVE" (default: same as target group protocol)
    }
  },
  {
    index     = "tg-runner"
    name      = "tg-runner"
    vpc_index = "sillaeng-demo-service-vpc"
    port      = 80
    protocol  = "HTTP"
    target_id = ["ec2-runner0001", "ec2-runner0002"]

    # Health check configuration
    # All fields are optional, defaults will be used if not specified
    health_check = {
      enabled             = true                    # Enable or disable health checks (default: true)
      interval            = 30                      # Health check interval in seconds (default: 30)
      path                = "/"                     # Health check path (default: "/")
      timeout             = 10                      # Health check timeout in seconds (default: 10)
      matcher             = "200-399"                    # HTTP status codes to consider healthy (default: "200")
      healthy_threshold   = 3                       # Number of consecutive successful checks (default: 3)
      unhealthy_threshold = 3                       # Number of consecutive failed checks (default: 3)
      port                = "traffic-port"          # Health check port: "traffic-port" or specific port number (default: "traffic-port")
      protocol            = null                    # Health check protocol: "HTTP", "HTTPS", "TCP", "TCP_UDP", "TLS", "UDP", "GENEVE" (default: same as target group protocol)
    }
  },
  # NLB Target Group for ALB connection
  {
    index        = "tg-runner-nlb"
    name         = "tg-runner-nlb"
    vpc_index    = "sillaeng-demo-service-vpc"
    port         = 443
    protocol     = "TCP"
    target_type  = "alb"
    target_lb    = ["ext-runner-alb-01"]  # ALB to connect

    # Health check configuration for NLB
    health_check = {
      enabled             = true
      interval            = 30
      timeout             = 10
      healthy_threshold   = 3
      unhealthy_threshold = 3
      port                = "traffic-port"
      protocol            = "TCP"
    }
  },  
]
