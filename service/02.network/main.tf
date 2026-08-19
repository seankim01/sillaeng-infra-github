module "network" {
  source = "../../modules/Network/vpc"

  # tag
  company = var.company
  env     = var.env
  # vpc
  vpc                 = var.vpc
  subnet              = var.subnet
  nat_create          = var.nat_create
  rt_rule_data        = csvdecode(file("./route_rules.csv"))
  sg_rule_data        = csvdecode(file("./security_group_rules.csv"))
  tgw_create          = {}
  vpc_endpoint_create = var.vpc_endpoint_create
}

# VPN Gateway (VGW) - TGW 대신 VGW로 IDC 직접 연결
resource "aws_vpn_gateway" "this" {
  vpc_id = module.network.vpc_info["sillaeng-demo-service-vpc"].id

  tags = {
    Name = format("%s-%s-service-vgw", var.company, var.env)
    Env  = var.env
  }
}

# Customer Gateway - IDC 연결
resource "aws_customer_gateway" "this" {
  for_each = { for cgw in var.cgw : cgw.index => cgw }

  bgp_asn    = each.value.bgp_asn
  ip_address = each.value.ip_address
  type       = each.value.type

  tags = {
    Name = format("%s-%s-%s", var.company, var.env, each.value.name)
    Env  = var.env
  }
}

# Site-to-Site VPN Connection (VGW 기반)
resource "aws_vpn_connection" "this" {
  for_each = { for vpn in var.vpn : vpn.index => vpn }

  vpn_gateway_id      = aws_vpn_gateway.this.id
  customer_gateway_id = aws_customer_gateway.this[each.value.customer_gateway_id].id
  type                = each.value.type
  static_routes_only  = each.value.static_routes_only

  tags = {
    Name = format("%s-%s-%s", var.company, var.env, each.value.purpose)
    Env  = var.env
  }
}

# VPN Gateway Route Propagation
resource "aws_vpn_gateway_route_propagation" "private" {
  for_each = toset([
    "service-private-app",
    "service-private-gpu-infer",
    "service-private-gpu-train",
    "service-private-dev",
    "service-private-db",
    "service-private-devdb",
  ])

  vpn_gateway_id = aws_vpn_gateway.this.id
  route_table_id = module.network.rt_info[each.value].id
}
