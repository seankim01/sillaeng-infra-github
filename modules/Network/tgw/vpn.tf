# 사용시 주석 해제
// Customer gateway
resource "aws_customer_gateway" "this" {
  for_each        = { for _map in var.cgw : _map.index => _map }
  bgp_asn         = each.value.bgp_asn
  ip_address      = each.value.ip_address
  type            = each.value.type
  certificate_arn = lookup(each.value, "certificate_arn", null)
  device_name     = lookup(each.value, "device_name", null)

  tags = {
    Type = "customer gateway"
    Name = join("-", [
      var.company,
      var.env,
      each.value.purpose,
      each.value.name
    ])
  }
}

resource "aws_vpn_connection" "this" {
  for_each = { for _map in var.vpn : _map.index => _map }
  #vpn_gateway_id        = length(lookup(each.value, "vpn_gateway_id", "")) > 0 ? aws_vpn_gateway.this[each.value.vpn_gateway_id].id : null # vgw 사용 시 주석 해제
  transit_gateway_id       = length(lookup(each.value, "transit_gateway_id", "")) > 0 ? aws_ec2_transit_gateway.this[each.value.transit_gateway_id].id : null
  customer_gateway_id      = aws_customer_gateway.this[each.value.customer_gateway_id].id
  type                     = each.value.type
  local_ipv4_network_cidr  = lookup(each.value, "local_ipv4_network_cidr", "0.0.0.0/0")
  remote_ipv4_network_cidr = lookup(each.value, "remote_ipv4_network_cidr", "0.0.0.0/0")
  tunnel1_inside_cidr      = lookup(each.value, "tunnel1_inside_cidr", null)
  tunnel2_inside_cidr      = lookup(each.value, "tunnel2_inside_cidr", null)
  tunnel1_preshared_key    = lookup(each.value, "tunnel1_preshared_key", null)
  tunnel2_preshared_key    = lookup(each.value, "tunnel2_preshared_key", null)
  static_routes_only       = lookup(each.value, "static_routes_only", false)

  tags = {
    Type = "vpn connection"
    Name = join("-", [
      var.company,
      var.env,
      each.value.purpose
    ])
  }
}

resource "aws_ec2_tag" "this" {
  for_each    = { for _map in var.vpn : _map.index => _map }
  resource_id = aws_vpn_connection.this[each.value.index].transit_gateway_attachment_id
  key         = "Name"
  value = join("-", [
    var.company,
    var.env,
    "tgw-vpn-attachment"
  ])
}

# // Vpn gateway
# resource "aws_vpn_gateway" "this" {
#   for_each          = { for _map in var.vgw : _map.index => _map }
#   vpc_id            = aws_vpc.this[each.value.vpc_name].id
#   availability_zone = lookup(each.value, "availability_zone", null)
#   amazon_side_asn   = lookup(each.value, "amazon_side_asn", null)

#   tags = {
#     Type = "vpn gateway"
#     Name = join("-", [
#       var.company,
#       var.env,
#       each.value.type,
#       each.value.purpose
#     ])
#   }
# }

# resource "aws_vpn_gateway_attachment" "this" {
#   for_each       = { for _map in var.vgw : _map.index => _map }
#   vpc_id         = aws_vpc.this[each.value.vpc_name].id
#   vpn_gateway_id = aws_vpn_gateway.this[each.value.index].id
# }

# //Site to Site vpn
# # 세부 설정은 수정해야합니다.


