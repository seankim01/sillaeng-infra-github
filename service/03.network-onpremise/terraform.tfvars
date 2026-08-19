vpc = [
  {
    vpc_name             = "bundang-idc-bundang-vpc"
    service              = "bundang"
    cidr_block           = "192.168.0.0/16"
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
  {
    name                    = "bundang-pub-01a"
    vpc_name                = "bundang-idc-bundang-vpc"
    service                 = "bundang"
    zone                    = "ap-northeast-2a"
    cidr                    = "192.168.0.0/25"
    map_public_ip_on_launch = "true"
    position                = "bundang-public"
  },
  {
    name                    = "bundang-pub-02c"
    vpc_name                = "bundang-idc-bundang-vpc"
    service                 = "bundang"
    zone                    = "ap-northeast-2c"
    cidr                    = "192.168.0.128/25"
    map_public_ip_on_launch = "true"
    position                = "bundang-public"
  },
  {
    name                    = "bundang-pri-01a"
    vpc_name                = "bundang-idc-bundang-vpc"
    service                 = "bundang"
    zone                    = "ap-northeast-2a"
    cidr                    = "192.168.1.0/24"
    map_public_ip_on_launch = "false"
    position                = "bundang-private"
  },
  {
    name                    = "bundang-pri-02c"
    vpc_name                = "bundang-idc-bundang-vpc"
    service                 = "bundang"
    zone                    = "ap-northeast-2c"
    cidr                    = "192.168.2.0/24"
    map_public_ip_on_launch = "false"
    position                = "bundang-private"
  },
]

nat_create = [
  {
    index             = "bundang-nat-pub-01a"
    service           = "bundang"
    type              = "nat"
    sub_index         = "bundang-pub-01a"
    networkboudary    = "pub"
    connectivity_type = "public"
    availability_mode = "regional"
    eip_allocation_method = "automatic"
  },
]

# TGW 미사용
tgw_create = []
tgw_att_create = []
tgw_rtb_create = []
tgw_rtb_association_create = []
tgw_route_create = []
cgw = []
vpn = []
