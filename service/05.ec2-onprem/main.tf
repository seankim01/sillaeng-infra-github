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

# bundang-private 서브넷의 route table 조회
data "aws_route_table" "bundang_private" {
  subnet_id = data.terraform_remote_state.remote.outputs.subnet_info["bundang-pri-01a"].id
}

# Openswan EC2를 통한 VPN 경로 추가
# bundang-private 서브넷에서 sillaeng-demo-service-vpc(172.25.0.0/22)로 가는 트래픽을
# Openswan 인스턴스를 통해 라우팅
resource "aws_route" "vpn_to_service_vpc" {
  route_table_id         = data.aws_route_table.bundang_private.id
  destination_cidr_block = "172.25.0.0/22"
  network_interface_id   = module.ec2.ec2_info["bundang-ec2-public-bastion"].primary_network_interface_id

  depends_on = [module.ec2]
}
