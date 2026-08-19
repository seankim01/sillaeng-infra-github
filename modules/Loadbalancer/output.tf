output "loadbalancer_info" {
  value = aws_lb.this
}

output "target_group_info" {
  value = aws_lb_target_group.this
}
