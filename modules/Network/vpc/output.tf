output "vpc_info" {
  value = aws_vpc.this
}

output "subnet_info" {
  value = aws_subnet.this
}

output "sg_info" {
  value = aws_security_group.this
}

