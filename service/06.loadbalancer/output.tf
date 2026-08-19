output "alb_dns_name" {
  value       = { for k, v in module.lb.loadbalancer_info : k => v.dns_name }
  description = "ALB DNS name"
}
