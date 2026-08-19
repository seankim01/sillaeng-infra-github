module "lb" {
  source = "../../modules/loadbalancer"

  # tag
  company = var.company
  env     = var.env
  service = var.service


  lb_create                = var.lb_create
  lb_listener_create       = var.lb_listener_create
  lb_listener_rules_create = var.lb_listener_rules_create
  tg_create                = var.tg_create

  vpc_info    = data.terraform_remote_state.remote.outputs.vpc_info
  subnet_info = data.terraform_remote_state.remote.outputs.subnet_info
  sg_info     = data.terraform_remote_state.remote.outputs.sg_info
  ec2_info    = try(data.terraform_remote_state.remote_ec2.outputs.ec2_info, {})
}
