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
  vpc_endpoint_create = []
}
