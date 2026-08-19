output "vpc_info" {
  value       = module.network.vpc_info
  description = "vpc information map type output."
}

output "subnet_info" {
  value       = module.network.subnet_info
  description = "subnet information map type output."
}

output "sg_info" {
  value       = module.network.sg_info
  description = "sg information map type output."
}

output "rt_info" {
  value       = module.network.rt_info
  description = "route table information map type output."
}

# 추후 VPN 설치 시 주석 해제
# output "vpn_gateway_id" {
#   value       = aws_vpn_gateway.this.id
#   description = "VPN Gateway ID"
# }
#
# output "vpn_connection_info" {
#   value       = { for k, v in aws_vpn_connection.this : k => v.id }
#   description = "VPN Connection information."
# }
