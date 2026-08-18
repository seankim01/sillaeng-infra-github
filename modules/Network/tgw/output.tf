output "tgw_info" {
  value = aws_ec2_transit_gateway.this
}
output "vpn_info" {
  value = aws_vpn_connection.this
}
