output "ec2_info" {
  value       = module.ec2.ec2_info
  description = "ec2 information map type output."
}

output "openswan_public_ip" {
  value       = module.ec2.ec2_info["bundang-ec2-public-bastion"].public_ip
  description = "Openswan EC2 Public IP (EIP) - 02.network CGW ip_address에 사용"
}


