vpc = [
  {
    vpc_name             = "sillaeng-demo-service-vpc"
    service              = "service"
    cidr_block           = "172.25.0.0/22"
    enable_dns_hostnames = true
    enable_dns_support   = true
    enable_ipv6          = false
    secondary_cidr_block = null
    aws_internet_gateway = true
    flowlog              = true
    flowlog_type         = "ALL"
  },
]

subnet = [
  # ============================================
  # Public Subnet (NAT GW, Bastion Host, ALB)
  # ============================================
  {
    name                    = "service-pub-01a"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.25.0.0/26"
    map_public_ip_on_launch = "true"
    position                = "service-public"
  },
  {
    name                    = "service-pub-02c"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.25.0.64/26"
    map_public_ip_on_launch = "true"
    position                = "service-public"
  },

  # ============================================
  # Private Subnet - App 서버 (m6i.xlarge)
  # ============================================
  {
    name                    = "service-pri-app-01a"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.25.0.128/26"
    map_public_ip_on_launch = "false"
    position                = "service-private-app"
  },
  {
    name                    = "service-pri-app-02c"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.25.0.192/26"
    map_public_ip_on_launch = "false"
    position                = "service-private-app"
  },

  # ============================================
  # Private Subnet - GPU 운영 추론 서버 (g6e.xlarge)
  # ============================================
  {
    name                    = "service-pri-gpu-infer-01a"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.25.1.0/26"
    map_public_ip_on_launch = "false"
    position                = "service-private-gpu-infer"
  },
  {
    name                    = "service-pri-gpu-infer-02c"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.25.1.64/26"
    map_public_ip_on_launch = "false"
    position                = "service-private-gpu-infer"
  },

  # ============================================
  # Private Subnet - GPU 학습/개발 서버 (g6e.xlarge x2)
  # ============================================
  {
    name                    = "service-pri-gpu-train-01a"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.25.1.128/26"
    map_public_ip_on_launch = "false"
    position                = "service-private-gpu-train"
  },
  {
    name                    = "service-pri-gpu-train-02c"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.25.1.192/26"
    map_public_ip_on_launch = "false"
    position                = "service-private-gpu-train"
  },

  # ============================================
  # Private Subnet - 개발 서버 (t3.large)
  # ============================================
  {
    name                    = "service-pri-dev-01a"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.25.2.0/26"
    map_public_ip_on_launch = "false"
    position                = "service-private-dev"
  },
  {
    name                    = "service-pri-dev-02c"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.25.2.64/26"
    map_public_ip_on_launch = "false"
    position                = "service-private-dev"
  },

  # ============================================
  # Private Subnet - 운영 DB (RDS PostgreSQL Multi-AZ)
  # ============================================
  {
    name                    = "service-pri-db-01a"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.25.2.128/27"
    map_public_ip_on_launch = "false"
    position                = "service-private-db"
  },
  {
    name                    = "service-pri-db-02c"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.25.2.160/27"
    map_public_ip_on_launch = "false"
    position                = "service-private-db"
  },

  # ============================================
  # Private Subnet - 개발 DB (RDS PostgreSQL)
  # ============================================
  {
    name                    = "service-pri-devdb-01a"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.25.2.192/27"
    map_public_ip_on_launch = "false"
    position                = "service-private-devdb"
  },
  {
    name                    = "service-pri-devdb-02c"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.25.2.224/27"
    map_public_ip_on_launch = "false"
    position                = "service-private-devdb"
  },
]

# NAT Gateway - Regional (단일 NAT GW로 모든 AZ 커버, 비용 절감)
nat_create = [
  {
    index             = "service-nat-regional"
    service           = "service"
    type              = "nat"
    sub_index         = "service-pub-01a"
    networkboudary    = "pub"
    connectivity_type = "public"
    availability_mode = "regional"
    eip_allocation_method = "automatic"
  },
]

# TGW 삭제 - 빈 배열
tgw_create = []
tgw_att_create = []
tgw_rtb_create = []
tgw_rtb_association_create = []
tgw_route_create = []

# VPN - Site-to-Site VPN (VPN Gateway 직접 연결, TGW 미사용)
# IDC 연결용 Customer Gateway + VPN Connection
# 추후 VPN 설치 시 주석 해제
# cgw = [
#   {
#     index      = "cgw-01"
#     purpose    = "idc"
#     name       = "sillaeng-cgw-idc"
#     bgp_asn    = 65001
#     ip_address = "15.164.136.35" # IDC 보안장비 Public IP
#     type       = "ipsec.1"
#   },
# ]

# vpn = [
#   {
#     index               = "s2s-01"
#     purpose             = "sillaeng-idc-vpn"
#     vpc_name            = "sillaeng-demo-service-vpc"
#     customer_gateway_id = "cgw-01"
#     type                = "ipsec.1"
#     static_routes_only  = true
#   },
# ]

cgw = []
vpn = []

# VPC Endpoints - S3 Gateway Endpoint
vpc_endpoint_create = [
  # S3 Gateway Endpoint
  {
    index             = "ep-s3-service"
    vpc_name          = "sillaeng-demo-service-vpc"
    service           = "service"
    vpc_endpoint_type = "Gateway"
    service_name      = "com.amazonaws.ap-northeast-2.s3"
    route_table_positions = ["service-public", "service-private-app", "service-private-gpu-infer", "service-private-gpu-train", "service-private-dev"]
  },

  # SSM Interface Endpoint
  {
    index                = "ep-ssm-service"
    vpc_name             = "sillaeng-demo-service-vpc"
    service              = "service"
    vpc_endpoint_type    = "Interface"
    service_name         = "com.amazonaws.ap-northeast-2.ssm"
    subnet_names         = ["service-pri-app-01a", "service-pri-app-02c"]
    security_group_names = ["service-private-endpoint"]
    private_dns_enabled  = true
  },

  # SSM Messages Interface Endpoint
  {
    index                = "ep-ssmmessages-service"
    vpc_name             = "sillaeng-demo-service-vpc"
    service              = "service"
    vpc_endpoint_type    = "Interface"
    service_name         = "com.amazonaws.ap-northeast-2.ssmmessages"
    subnet_names         = ["service-pri-app-01a", "service-pri-app-02c"]
    security_group_names = ["service-private-endpoint"]
    private_dns_enabled  = true
  },

  # EC2 Messages Interface Endpoint
  {
    index                = "ep-ec2messages-service"
    vpc_name             = "sillaeng-demo-service-vpc"
    service              = "service"
    vpc_endpoint_type    = "Interface"
    service_name         = "com.amazonaws.ap-northeast-2.ec2messages"
    subnet_names         = ["service-pri-app-01a", "service-pri-app-02c"]
    security_group_names = ["service-private-endpoint"]
    private_dns_enabled  = true
  },
]
