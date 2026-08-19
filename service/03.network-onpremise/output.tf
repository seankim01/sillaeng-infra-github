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
