module "ec2" {
  source = "../../modules/EC2"

  # tag
  company = var.company
  env     = var.env

  ec2_create        = var.ec2_create
  iam_create        = var.iam_create
  iam_policy_create = var.iam_policy_create
  iam_policy_attach = var.iam_policy_attach
  subnet_info       = data.terraform_remote_state.remote.outputs.subnet_info
  sg_info           = data.terraform_remote_state.remote.outputs.sg_info
}
