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

output "tgw_info" {
  value       = module.tgw.tgw_info
  description = "tgw information map type output."
}
# output "vpn_info" {
#   value       = module.tgw.vpn_info
#   description = "vpn information map type output."
# }
