module "network" {
  source = "../../modules/Network/vpc"

  # tag
  company = var.company
  env     = var.env
  # vpc
  vpc          = var.vpc
  subnet       = var.subnet
  nat_create   = var.nat_create
  rt_rule_data = csvdecode(file("./route_rules.csv"))
  sg_rule_data = csvdecode(file("./security_group_rules.csv"))
  tgw_create   = module.tgw.tgw_info
}

module "tgw" {
  source = "../../modules/Network/tgw"

  # tag
  company = var.company
  env     = var.env

  vpc    = module.network.vpc_info
  subnet = module.network.subnet_info

  tgw_create                 = var.tgw_create
  tgw_att_create             = var.tgw_att_create
  tgw_rtb_create             = var.tgw_rtb_create
  tgw_rtb_association_create = var.tgw_rtb_association_create
  tgw_route_create           = var.tgw_route_create
  # VPN 사용 시 주석 해제
  cgw = var.cgw
  vpn = var.vpn
}
