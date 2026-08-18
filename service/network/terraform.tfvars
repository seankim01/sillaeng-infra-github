vpc = [
  {
    vpc_name             = "sillaeng-demo-mng-vpc"
    service              = "mng"
    cidr_block           = "172.24.0.0/24"
    enable_dns_hostnames = true
    enable_dns_support   = true
    enable_ipv6          = false
    secondary_cidr_block = null
    aws_internet_gateway = true
    flowlog              = true # true or false
    flowlog_type         = "ALL"
  },
  {
    vpc_name             = "sillaeng-demo-service-vpc"
    service              = "service"
    cidr_block           = "172.25.0.0/22"    
    enable_dns_hostnames = true
    enable_dns_support   = true
    enable_ipv6          = false
    secondary_cidr_block = null
    aws_internet_gateway = true
    flowlog              = false # true or false    
  },

  {
    vpc_name             = "sillaeng-demo-dev-vpc"
    service              = "dev"
    cidr_block           = "172.26.0.0/24"
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
    name                    = "mng-pub-01a"
    vpc_name                = "sillaeng-demo-mng-vpc"
    service                 = "mng"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.24.0.0/27"
    map_public_ip_on_launch = "true"
    position                = "mng-public"
  },
  {
    name                    = "mng-pub-02c"
    vpc_name                = "sillaeng-demo-mng-vpc"
    service                 = "mng"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.24.0.32/27"
    map_public_ip_on_launch = "true"
    position                = "mng-public"
  },
  {
    name                    = "mng-pri-01a"
    vpc_name                = "sillaeng-demo-mng-vpc"
    service                 = "mng"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.24.0.64/26"
    map_public_ip_on_launch = "false"
    position                = "mng-private"
  },
  {
    name                    = "mng-pri-02c"
    vpc_name                = "sillaeng-demo-mng-vpc"
    service                 = "mng"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.24.0.128/26"
    map_public_ip_on_launch = "false"
    position                = "mng-private"
  },
  {
    name                    = "mng-pri-tgw-01a"
    vpc_name                = "sillaeng-demo-mng-vpc"
    service                 = "mng"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.24.0.192/28"
    map_public_ip_on_launch = "false"
    position                = "mng-private-tgw"
  },
  {
    name                    = "mng-pri-tgw-02c"
    vpc_name                = "sillaeng-demo-mng-vpc"
    service                 = "mng"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.24.0.208/28"
    map_public_ip_on_launch = "false"
    position                = "mng-private-tgw"
  },
  
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
  {
    name                    = "service-pri-01a"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.25.1.0/24"
    map_public_ip_on_launch = "false"
    position                = "service-private"
  },
  {
    name                    = "service-pri-02c"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.25.2.0/24"
    map_public_ip_on_launch = "false"
    position                = "service-private"
  },
  {
    name                    = "service-pri-cache-01a"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.25.3.0/27"
    map_public_ip_on_launch = "false"
    position                = "service-private-cache"
  },
  {
    name                    = "service-pri-cache-02c"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.25.3.32/27"
    map_public_ip_on_launch = "false"
    position                = "service-private-cache"
  },

  {
    name                    = "service-pri-db-01a"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.25.3.64/27"
    map_public_ip_on_launch = "false"
    position                = "service-private-db"
  },
  {
    name                    = "service-pri-db-02c"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.25.3.96/27"
    map_public_ip_on_launch = "false"
    position                = "service-private-db"
  },
  {
    name                    = "service-pri-tgw-01a"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.25.3.128/28"
    map_public_ip_on_launch = "false"
    position                = "service-private-tgw"
  },
  {
    name                    = "service-pri-tgw-02c"
    vpc_name                = "sillaeng-demo-service-vpc"
    service                 = "service"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.25.3.144/28"
    map_public_ip_on_launch = "false"
    position                = "service-private-tgw"
  },





{
    name                    = "dev-pub-01a"
    vpc_name                = "sillaeng-demo-dev-vpc"
    service                 = "dev"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.26.0.0/27"
    map_public_ip_on_launch = "true"
    position                = "dev-public"
  },
  {
    name                    = "dev-pub-02c"
    vpc_name                = "sillaeng-demo-dev-vpc"
    service                 = "dev"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.26.0.32/27"
    map_public_ip_on_launch = "true"
    position                = "dev-public"
  },
  {
    name                    = "dev-pri-01a"
    vpc_name                = "sillaeng-demo-dev-vpc"
    service                 = "dev"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.26.0.64/26"
    map_public_ip_on_launch = "false"
    position                = "dev-private"
  },
  {
    name                    = "dev-pri-02c"
    vpc_name                = "sillaeng-demo-dev-vpc"
    service                 = "dev"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.26.0.128/26"
    map_public_ip_on_launch = "false"
    position                = "dev-private"
  },

  {
    name                    = "dev-pri-db-01a"
    vpc_name                = "sillaeng-demo-dev-vpc"
    service                 = "dev"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.26.0.192/28"
    map_public_ip_on_launch = "false"
    position                = "dev-private-db"
  },
  {
    name                    = "dev-pri-db-02c"
    vpc_name                = "sillaeng-demo-dev-vpc"
    service                 = "dev"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.26.0.208/28"
    map_public_ip_on_launch = "false"
    position                = "dev-private-db"
  },
  {
    name                    = "dev-pri-tgw-01a"
    vpc_name                = "sillaeng-demo-dev-vpc"
    service                 = "dev"
    zone                    = "ap-northeast-2a"
    cidr                    = "172.26.0.224/28"
    map_public_ip_on_launch = "false"
    position                = "dev-private-tgw"
  },
  {
    name                    = "dev-pri-tgw-02c"
    vpc_name                = "sillaeng-demo-dev-vpc"
    service                 = "dev"
    zone                    = "ap-northeast-2c"
    cidr                    = "172.26.0.240/28"
    map_public_ip_on_launch = "false"
    position                = "dev-private-tgw"
  }


]

nat_create = [
  {
    index             = "mng-nat-pub-01a"
    service           = "mng"
    type              = "nat"
    sub_index         = "mng-pub-01a"
    networkboudary     = "pub"
    connectivity_type = "public"
    # availability_mode: "zonal" (default, single-AZ) or "regional" (multi-AZ)
    availability_mode = "regional"  # Options: "zonal" or "regional"
    # Method of EIP allocation: "automatic" (default) or "manual"
    # - "automatic": EIPs are auto-generated for each AZ (only for regional mode with connectivity_type = "public")
    # - "manual": You must specify availability_zone_addresses with existing EIP allocation IDs
    eip_allocation_method = "automatic"  # Options: "automatic" or "manual"
    # Required when eip_allocation_method = "manual" and availability_mode = "regional"
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
]

tgw_create = [
  {
    name                            = "shared"
    amazon_side_asn                 = 64513
    default_route_table_association = "disable"
    default_route_table_propagation = "disable"
  }
]

tgw_att_create = [
  {
    name                                            = "mng"
    sub_index                                       = ["mng-pri-tgw-01a", "mng-pri-tgw-02c"]
    vpc_name                                        = "sillaeng-demo-mng-vpc"
    tgw_name                                        = "shared"
    transit_gateway_default_route_table_association = false
  },
  {
    name                                            = "service"
    sub_index                                       = ["service-pri-tgw-01a", "service-pri-tgw-02c"]
    vpc_name                                        = "sillaeng-demo-service-vpc"
    tgw_name                                        = "shared"
    transit_gateway_default_route_table_association = false
  },
  {
    name                                            = "dev"
    sub_index                                       = ["dev-pri-tgw-01a", "dev-pri-tgw-02c"]
    vpc_name                                        = "sillaeng-demo-dev-vpc"
    tgw_name                                        = "shared"
    transit_gateway_default_route_table_association = false
  },  
]

tgw_rtb_create = [
  {
    name       = "mng-rtb"
    tgw        = "shared"
    vpc_attach = "mng"
  },
  {
    name       = "service-rtb"
    tgw        = "shared"
    vpc_attach = "service"
  },
  {
    name       = "dev-rtb"
    tgw        = "shared"
    vpc_attach = "dev"
  },  

  {
    name       = "bundang-vpn-rtb"
    tgw        = "shared"
    #vpc_attach = "s2s-01"
  }, 

  {
    name       = "nonhyeon-vpn-rtb"
    tgw        = "shared"
    #vpc_attach = "s2s-02"
  }, 

]

tgw_rtb_association_create = [
  {
    name         = "mng"
    rtb          = "mng-rtb"
    tgw          = "shared"
    vpn_required = false
    tgw_att      = "mng"

  },

  {
    name         = "bundang-vpn"
    rtb          = "bundang-vpn-rtb"
    tgw          = "shared"
    vpn_required = true
    tgw_att      = "s2s-01"
  },

  {
    name         = "nonhyeon-vpn"
    rtb          = "nonhyeon-vpn-rtb"
    tgw          = "shared"
    vpn_required = true
    tgw_att      = "s2s-02"
  },  

 
  {
    name         = "service"
    rtb          = "service-rtb"
    tgw          = "shared"
    vpn_required = false
    tgw_att      = "service"
  },
  {
    name         = "dev"
    rtb          = "dev-rtb"
    tgw          = "shared"
    vpn_required = false
    tgw_att      = "dev"
  },
]


tgw_route_create = [


  {
    name                   = "mng-bundang-vpn"
    destination_cidr_block = "192.168.0.0/16"  
    vpn_required           = true
    tgw_rtb                = "mng-rtb"  
    tgw_att                = "s2s-01"          
  },  

  {
    name                   = "mng-nonhyeon-vpn"
    destination_cidr_block = "172.22.0.0/16"  
    vpn_required           = true
    tgw_rtb                = "mng-rtb"  
    tgw_att                = "s2s-02"          
  },  

  {
    name                   = "mng-service"
    destination_cidr_block = "172.25.0.0/22"
    vpn_required           = false
    tgw_rtb                = "mng-rtb"
    tgw_att                = "service"
  },
  {
    name                   = "mng-dev"
    destination_cidr_block = "172.26.0.0/24"
    vpn_required           = false
    tgw_rtb                = "mng-rtb"
    tgw_att                = "dev"
  },


  {
    name                   = "bundang-vpn-local"
    destination_cidr_block = "192.168.0.0/16"  
    vpn_required           = true
    tgw_rtb                = "bundang-vpn-rtb"  
    tgw_att                = "s2s-01"          
  },  
  {
    name                   = "bundang-vpn-mng"
    destination_cidr_block = "172.24.0.0/24"
    vpn_required           = false
    tgw_rtb                = "bundang-vpn-rtb"
    tgw_att                = "mng"
  },
  {
    name                   = "bundang-vpn-svc"
    destination_cidr_block = "172.25.0.0/22"
    vpn_required           = false
    tgw_rtb                = "bundang-vpn-rtb"
    tgw_att                = "service"
  },
  {
    name                   = "bundang-vpn-dev"
    destination_cidr_block = "172.26.0.0/24"
    vpn_required           = false
    tgw_rtb                = "bundang-vpn-rtb"
    tgw_att                = "dev"
  },  



  {
    name                   = "nonhyeon-vpn-local"
    destination_cidr_block = "172.22.0.0/16"  
    vpn_required           = true
    tgw_rtb                = "nonhyeon-vpn-rtb"
    tgw_att                = "s2s-02"          
  },  
    {
    name                   = "nonhyeon-vpn-mng"
    destination_cidr_block = "172.24.0.0/24"
    vpn_required           = false
    tgw_rtb                = "nonhyeon-vpn-rtb"
    tgw_att                = "mng"
  },
  {
    name                   = "nonhyeon-vpn-svc"
    destination_cidr_block = "172.25.0.0/22"
    vpn_required           = false
    tgw_rtb                = "nonhyeon-vpn-rtb"
    tgw_att                = "service"
  },
  {
    name                   = "nonhyeon-vpn-dev"
    destination_cidr_block = "172.26.0.0/24"
    vpn_required           = false
    tgw_rtb                = "nonhyeon-vpn-rtb"
    tgw_att                = "dev"
  },  




  {
    name                   = "service-bundang-vpn"
    destination_cidr_block = "192.168.0.0/16"  
    vpn_required           = true
    tgw_rtb                = "service-rtb"  
    tgw_att                = "s2s-01"          
  },  

  {
    name                   = "service-nonhyeon-vpn"
    destination_cidr_block = "172.22.0.0/16"  
    vpn_required           = true
    tgw_rtb                = "service-rtb"  
    tgw_att                = "s2s-02"          
  },  

  {
    name                   = "service-mng"
    destination_cidr_block = "172.24.0.0/24"
    vpn_required           = false
    tgw_rtb                = "service-rtb"
    tgw_att                = "mng"
  },
  {
    name                   = "service-dev"
    destination_cidr_block = "172.26.0.0/24"
    vpn_required           = false
    tgw_rtb                = "service-rtb"
    tgw_att                = "dev"
  },
  {
    name                   = "service-nat"
    destination_cidr_block = "0.0.0.0/0"
    vpn_required           = false
    tgw_rtb                = "service-rtb"
    tgw_att                = "mng"
  },




  {
    name                   = "dev-bundang-vpn"
    destination_cidr_block = "192.168.0.0/16"  
    vpn_required           = true
    tgw_rtb                = "dev-rtb"  
    tgw_att                = "s2s-01"          
  },  

  {
    name                   = "dev-nonhyeon-vpn"
    destination_cidr_block = "172.22.0.0/16"  
    vpn_required           = true
    tgw_rtb                = "dev-rtb"  
    tgw_att                = "s2s-02"          
  },  

  {
    name                   = "dev-mng"
    destination_cidr_block = "172.24.0.0/24"
    vpn_required           = false
    tgw_rtb                = "dev-rtb"
    tgw_att                = "mng"
  },
  {
    name                   = "dev-nat"
    destination_cidr_block = "0.0.0.0/0"
    vpn_required           = false
    tgw_rtb                = "dev-rtb"
    tgw_att                = "mng"
  },



]



#VPN 연결 확정 시 에  주석 해제
cgw = [
  {
    index      = "cgw-01"
    purpose    = "shared"
    name       = "bundang-cgw-idc"
    bgp_asn    = 65001
    ip_address = "13.124.27.97" # Openswan EC2 Public IP
    type       = "ipsec.1"
  },
  {
    index      = "cgw-02"
    purpose    = "shared"
    name       = "nonhyeon-cgw-idc"
    bgp_asn    = 65002
    ip_address = "52.78.63.170" # Openswan EC2 Public IP
    type       = "ipsec.1"
  }  
]
vpn = [
  {
    index               = "s2s-01"
    purpose             = "bundang-shared-vpn"
    transit_gateway_id  = "shared"
    customer_gateway_id = "cgw-01"
    type                = "ipsec.1"
    static_routes_only  = true
  },
  {
    index               = "s2s-02"
    purpose             = "nonhyeon-shared-vpn"
    transit_gateway_id  = "shared"
    customer_gateway_id = "cgw-02"
    type                = "ipsec.1"
    static_routes_only  = true
  }  
]

# VPC Endpoints
# Gateway endpoints: S3, DynamoDB (automatically adds routes to route tables)
# Interface endpoints: SSM, SSM Messages, EC2 Messages (requires subnets and security groups)
vpc_endpoint_create = [
  # S3 Gateway Endpoint (for S3 access without internet gateway)
  {
    index             = "ep-s3-mng"
    vpc_name          = "sillaeng-demo-mng-vpc"
    service           = "mng"
    vpc_endpoint_type = "Gateway"
    service_name      = "com.amazonaws.ap-northeast-2.s3"
    # Route table positions where the endpoint will be added
    # Use position values from subnet configuration (e.g., "mng-public", "mng-private")
    route_table_positions = ["mng-public", "mng-private"]
  },
  {
    index             = "ep-s3-service"
    vpc_name          = "sillaeng-demo-service-vpc"
    service           = "service"
    vpc_endpoint_type = "Gateway"
    service_name      = "com.amazonaws.ap-northeast-2.s3"
    route_table_positions = ["service-public", "service-private"]
  },
  {
    index             = "ep-s3-dev"
    vpc_name          = "sillaeng-demo-dev-vpc"
    service           = "dev"
    vpc_endpoint_type = "Gateway"
    service_name      = "com.amazonaws.ap-northeast-2.s3"
    route_table_positions = ["dev-public", "dev-private"]
  },
  
  # SSM Interface Endpoint (for Systems Manager)
  {
    index                = "ep-ssm-mng"
    vpc_name             = "sillaeng-demo-mng-vpc"
    service              = "mng"
    vpc_endpoint_type    = "Interface"
    service_name         = "com.amazonaws.ap-northeast-2.ssm"
    subnet_names         = ["mng-pri-01a", "mng-pri-02c"]  # Private subnets
    security_group_names = ["mng-private-bastion-ec2"]     # Security group name from security_group_rules.csv
    private_dns_enabled   = true
  },
  {
    index                = "ep-ssm-service"
    vpc_name             = "sillaeng-demo-service-vpc"
    service              = "service"
    vpc_endpoint_type    = "Interface"
    service_name         = "com.amazonaws.ap-northeast-2.ssm"
    subnet_names         = ["service-pri-01a", "service-pri-02c"]
    security_group_names = ["service-private-bastion-ec2"]
    private_dns_enabled   = true
  },
  {
    index                = "ep-ssm-dev"
    vpc_name             = "sillaeng-demo-dev-vpc"
    service              = "dev"
    vpc_endpoint_type    = "Interface"
    service_name         = "com.amazonaws.ap-northeast-2.ssm"
    subnet_names         = ["dev-pri-01a", "dev-pri-02c"]
    security_group_names = ["dev-private-bastion-ec2"]
    private_dns_enabled   = true
  },
  
  # SSM Messages Interface Endpoint
  {
    index                = "ep-ssmmessages-mng"
    vpc_name             = "sillaeng-demo-mng-vpc"
    service              = "mng"
    vpc_endpoint_type    = "Interface"
    service_name         = "com.amazonaws.ap-northeast-2.ssmmessages"
    subnet_names         = ["mng-pri-01a", "mng-pri-02c"]
    security_group_names = ["mng-private-bastion-ec2"]
    private_dns_enabled   = true
  },
  {
    index                = "ep-ssmmessages-service"
    vpc_name             = "sillaeng-demo-service-vpc"
    service              = "service"
    vpc_endpoint_type    = "Interface"
    service_name         = "com.amazonaws.ap-northeast-2.ssmmessages"
    subnet_names         = ["service-pri-01a", "service-pri-02c"]
    security_group_names = ["service-private-bastion-ec2"]
    private_dns_enabled   = true
  },
  {
    index                = "ep-ssmmessages-dev"
    vpc_name             = "sillaeng-demo-dev-vpc"
    service              = "dev"
    vpc_endpoint_type    = "Interface"
    service_name         = "com.amazonaws.ap-northeast-2.ssmmessages"
    subnet_names         = ["dev-pri-01a", "dev-pri-02c"]
    security_group_names = ["dev-private-bastion-ec2"]
    private_dns_enabled   = true
  },
  
  # EC2 Messages Interface Endpoint
  {
    index                = "ep-ec2messages-mng"
    vpc_name             = "sillaeng-demo-mng-vpc"
    service              = "mng"
    vpc_endpoint_type    = "Interface"
    service_name         = "com.amazonaws.ap-northeast-2.ec2messages"
    subnet_names         = ["mng-pri-01a", "mng-pri-02c"]
    security_group_names = ["mng-private-bastion-ec2"]
    private_dns_enabled   = true
  },
  {
    index                = "ep-ec2messages-service"
    vpc_name             = "sillaeng-demo-service-vpc"
    service              = "service"
    vpc_endpoint_type    = "Interface"
    service_name         = "com.amazonaws.ap-northeast-2.ec2messages"
    subnet_names         = ["service-pri-01a", "service-pri-02c"]
    security_group_names = ["service-private-bastion-ec2"]
    private_dns_enabled   = true
  },
  {
    index                = "ep-ec2messages-dev"
    vpc_name             = "sillaeng-demo-dev-vpc"
    service              = "dev"
    vpc_endpoint_type    = "Interface"
    service_name         = "com.amazonaws.ap-northeast-2.ec2messages"
    subnet_names         = ["dev-pri-01a", "dev-pri-02c"]
    security_group_names = ["dev-private-bastion-ec2"]
    private_dns_enabled   = true
  },
]