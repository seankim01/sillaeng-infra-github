vpc = [
  {
    vpc_name             = "hsfms-idc-bundang-vpc"
    service              = "bundang"
    cidr_block           = "192.168.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    enable_ipv6          = false
    secondary_cidr_block = null
    aws_internet_gateway = true
    flowlog              = true # true or false
    flowlog_type         = "ALL"
  },
  {
    vpc_name             = "hsfms-idc-nonhyeon-vpc"
    service              = "nonhyeon"
    cidr_block           = "172.22.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    enable_ipv6          = false
    secondary_cidr_block = null
    aws_internet_gateway = true
    flowlog              = false # true or false    
  },
]
subnet = [
  {
    name                    = "bundang-pub-01a"
    vpc_name                = "hsfms-idc-bundang-vpc"
    service                 = "bundang"
    zone                    = "ap-northeast-2a"
    cidr                    = "192.168.0.0/25"
    map_public_ip_on_launch = "true"
    position                = "bundang-public"
  },
  {
    name                    = "bundang-pub-02c"
    vpc_name                = "hsfms-idc-bundang-vpc"
    service                 = "bundang"
    zone                    = "ap-northeast-2c"
    cidr                    = "192.168.0.128/25"
    map_public_ip_on_launch = "true"
    position                = "bundang-public"
  },
  {
    name                    = "bundang-pri-01a"
    vpc_name                = "hsfms-idc-bundang-vpc"
    service                 = "bundang"
    zone                    = "ap-northeast-2a"
    cidr                    = "192.168.1.0/24"
    map_public_ip_on_launch = "false"
    position                = "bundang-private"
  },
  {
    name                    = "bundang-pri-02c"
    vpc_name                = "hsfms-idc-bundang-vpc"
    service                 = "bundang"
    zone                    = "ap-northeast-2c"
    cidr                    = "192.168.2.0/24"
    map_public_ip_on_launch = "false"
    position                = "bundang-private"
  },
  {
    name                    = "bundang-pri-tgw-01a"
    vpc_name                = "hsfms-idc-bundang-vpc"
    service                 = "bundang"
    zone                    = "ap-northeast-2a"
    cidr                    = "192.168.3.0/28"
    map_public_ip_on_launch = "false"
    position                = "bundang-private-tgw"
  },
  {
    name                    = "bundang-pri-tgw-02c"
    vpc_name                = "hsfms-idc-bundang-vpc"
    service                 = "bundang"
    zone                    = "ap-northeast-2c"
    cidr                    = "192.168.3.16/28"
    map_public_ip_on_launch = "false"
    position                = "bundang-private-tgw"
  },



  {
    name                    = "nonhyeon-pub-01a"
    vpc_name                = "hsfms-idc-nonhyeon-vpc"
    service                 = "nonhyeon"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.22.0.0/25"
    map_public_ip_on_launch = "true"
    position                = "nonhyeon-public"
  },
  {
    name                    = "nonhyeon-pub-02c"
    vpc_name                = "hsfms-idc-nonhyeon-vpc"
    service                 = "nonhyeon"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.22.0.128/25"
    map_public_ip_on_launch = "true"
    position                = "nonhyeon-public"
  },
  {
    name                    = "nonhyeon-pri-01a"
    vpc_name                = "hsfms-idc-nonhyeon-vpc"
    service                 = "nonhyeon"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.22.1.0/24"
    map_public_ip_on_launch = "false"
    position                = "nonhyeon-private"
  },
  {
    name                    = "nonhyeon-pri-02c"
    vpc_name                = "hsfms-idc-nonhyeon-vpc"
    service                 = "nonhyeon"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.22.2.0/24"
    map_public_ip_on_launch = "false"
    position                = "nonhyeon-private"
  },

  {
    name                    = "nonhyeon-pri-tgw-01a"
    vpc_name                = "hsfms-idc-nonhyeon-vpc"
    service                 = "nonhyeon"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.22.3.0/28"
    map_public_ip_on_launch = "false"
    position                = "nonhyeon-private-tgw"
  },
  {
    name                    = "nonhyeon-pri-tgw-02c"
    vpc_name                = "hsfms-idc-nonhyeon-vpc"
    service                 = "nonhyeon"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.22.3.16/28"
    map_public_ip_on_launch = "false"
    position                = "nonhyeon-private-tgw"
  }
]

nat_create = [
  {
    index             = "bundang-nat-pub-01a"
    service           = "bundang"
    type              = "nat"
    sub_index         = "bundang-pub-01a"
    networkboudary    = "pub"
    connectivity_type = "public"
    # availability_mode: "zonal" (default, single-AZ) or "regional" (multi-AZ)
    # For regional mode with connectivity_type = "private", no EIPs are required
    # For regional mode with connectivity_type = "public", EIPs are auto-generated for each AZ if availability_zone_addresses is not specified
    availability_mode = "regional"  # Options: "zonal" or "regional"
    # Method of EIP allocation: "automatic" (default) or "manual"
    # - "automatic": EIPs are auto-generated for each AZ (only for regional mode with connectivity_type = "public")
    # - "manual": You must specify availability_zone_addresses with existing EIP allocation IDs    
    eip_allocation_method = "automatic"  # Options: "automatic" or "manual"    
    # Optional: Specify availability_zone_addresses to use existing EIPs (only for connectivity_type = "public")
    # If not specified and connectivity_type = "public", EIPs will be auto-generated for ap-northeast-2a and ap-northeast-2c
    # availability_zone_addresses = [
    #   {
    #     allocation_ids    = ["eipalloc-xxxxx"]  # Use allocation_ids (list) instead of allocation_id
    #     availability_zone = "ap-northeast-2a"
    #   },
    #   {
    #     allocation_ids    = ["eipalloc-yyyyy"]
    #     availability_zone = "ap-northeast-2c"
    #   }
    # ]
  },
  {
    index             = "nonhyeon-nat-pub-01a"
    service           = "nonhyeon"
    type              = "nat"
    sub_index         = "nonhyeon-pub-01a"
    networkboudary    = "pub"
    connectivity_type = "public"
    # availability_mode: "zonal" (default, single-AZ) or "regional" (multi-AZ)
    # For regional mode with connectivity_type = "private", no EIPs are required
    # For regional mode with connectivity_type = "public", EIPs are auto-generated for each AZ if availability_zone_addresses is not specified
    availability_mode = "regional"  # Options: "zonal" or "regional"
    # Method of EIP allocation: "automatic" (default) or "manual"
    # - "automatic": EIPs are auto-generated for each AZ (only for regional mode with connectivity_type = "public")
    # - "manual": You must specify availability_zone_addresses with existing EIP allocation IDs
    eip_allocation_method = "automatic"  # Options: "automatic" or "manual"
    # Optional: Specify availability_zone_addresses to use existing EIPs (only for connectivity_type = "public")
    # If not specified and connectivity_type = "public", EIPs will be auto-generated for ap-northeast-2a and ap-northeast-2c
    # availability_zone_addresses = [
    #   {
    #     allocation_ids    = ["eipalloc-xxxxx"]  # Use allocation_ids (list) instead of allocation_id
    #     availability_zone = "ap-northeast-2a"
    #   },
    #   {
    #     allocation_ids    = ["eipalloc-yyyyy"]
    #     availability_zone = "ap-northeast-2c"
    #   }
    # ]
  }  
]


# tgw_create = [
#   {
#     name                            = "shared"
#     amazon_side_asn                 = 64513
#     default_route_table_association = "disable"
#     default_route_table_propagation = "disable"
#   }
# ]

# tgw_att_create = [
#   {
#     name                                            = "bundang"
#     sub_index                                       = ["bundang-pri-tgw-01a", "bundang-pri-tgw-02c"]
#     vpc_name                                        = "hsfms-idc-bundang-vpc"
#     tgw_name                                        = "shared"
#     transit_gateway_default_route_table_association = false
#   },
#   {
#     name                                            = "nonhyeon"
#     sub_index                                       = ["nonhyeon-pri-tgw-01a", "nonhyeon-pri-tgw-02c"]
#     vpc_name                                        = "hsfms-idc-nonhyeon-vpc"
#     tgw_name                                        = "shared"
#     transit_gateway_default_route_table_association = false
#   },
# ]

# tgw_rtb_create = [
#   {
#     name       = "bundang-rtb"
#     tgw        = "shared"
#     vpc_attach = "bundang"
#   },
#   {
#     name       = "nonhyeon-rtb"
#     tgw        = "shared"
#     vpc_attach = "nonhyeon"
#   },
# ]

# tgw_rtb_association_create = [
#   {
#     name         = "bundang"
#     rtb          = "bundang-rtb"
#     tgw          = "shared"
#     vpn_required = false
#     tgw_att      = "bundang"
#   },
#   {
#     name         = "nonhyeon"
#     rtb          = "nonhyeon-rtb"
#     tgw          = "shared"
#     vpn_required = false
#     tgw_att      = "nonhyeon"
#   },
#   # {
#   #   name         = "bundang-vpn"
#   #   rtb          = "bundang-rtb"
#   #   tgw          = "shared"
#   #   vpn_required = true
#   #   tgw_att      = "s2s-01"
#   # },
# ]


# tgw_route_create = [
#   # {
#   #   name                   = "bundang-vpn-4"
#   #   destination_cidr_block = "192.168.4.0/24"
#   #   vpn_required           = true
#   #   tgw_rtb                = "bundang-rtb"
#   #   tgw_att                = "s2s-01" # vpn 연결시 vpn으로 변경 s2s-01
#   # },
#   # {
#   #   name                   = "bundang-vpn-5"
#   #   destination_cidr_block = "192.168.5.0/24"
#   #   vpn_required           = true
#   #   tgw_rtb                = "bundang-rtb"
#   #   tgw_att                = "s2s-01" # vpn 연결시 vpn으로 변경 s2s-01
#   # },
#   # {
#   #   name                   = "bundang-vpn-2"
#   #   destination_cidr_block = "192.168.2.0/24"
#   #   vpn_required           = true
#   #   tgw_rtb                = "bundang-rtb"
#   #   tgw_att                = "s2s-01" # vpn 연결시 vpn으로 변경 s2s-01
#   # },
#   {
#     name                   = "bundang-service"
#     destination_cidr_block = "172.23.0.0/22"
#     vpn_required           = false
#     tgw_rtb                = "bundang-rtb"
#     tgw_att                = "nonhyeon"
#   },
#   {
#     name                   = "nonhyeon-bundang-all"
#     destination_cidr_block = "0.0.0.0/0"
#     vpn_required           = false
#     tgw_rtb                = "nonhyeon-rtb"
#     tgw_att                = "bundang"
#   },
# ]

# #VPN 연결 확정 시 에  주석 해제
# # cgw = [
# #   {
# #     index      = "cgw-01"
# #     purpose    = "shared"
# #     name       = "cgw-idc"
# #     bgp_asn    = 65000
# #     #ip_address = "1.2.3.4" # hsfms IDC VPN 장비 IP 
# #     ip_address = "16.144.172.226" # Openswan EC2 Public IP
# #     type       = "ipsec.1"
# #   }
# # ]
# # vpn = [
# #   {
# #     index               = "s2s-01"
# #     purpose             = "shared-vpn"
# #     transit_gateway_id  = "shared"
# #     customer_gateway_id = "cgw-01"
# #     type                = "ipsec.1"
# #     static_routes_only  = true
# #   }
# # ]