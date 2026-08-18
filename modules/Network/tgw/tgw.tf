resource "aws_ec2_transit_gateway" "this" {
  for_each                        = { for s_map in var.tgw_create : s_map.name => s_map }
  description                     = lookup(each.value, "description", null)
  amazon_side_asn                 = lookup(each.value, "amazon_side_asn", 64512)
  auto_accept_shared_attachments  = lookup(each.value, "auto_accept_shared_attachments", "disable")
  default_route_table_association = lookup(each.value, "default_route_table_association", "enable")
  default_route_table_propagation = lookup(each.value, "default_route_table_propagation", "enable")
  dns_support                     = lookup(each.value, "dns_support", "enable")
  multicast_support               = lookup(each.value, "multicast_support", "disable")
  transit_gateway_cidr_blocks     = lookup(each.value, "transit_gateway_cidr_blocks", null)
  vpn_ecmp_support                = lookup(each.value, "vpn_ecmp_support", "enable")

  tags = merge(
    {
      Name = format(
        "%s-%s-tgw-%s",
        var.company,
        var.env,
        each.value.name
      ),
      Env = var.env
    },
  lookup(each.value, "custom_tags", null))
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  for_each                                        = { for s_map in var.tgw_att_create : s_map.name => s_map }
  subnet_ids                                      = [for subnet_ids in each.value.sub_index : var.subnet[subnet_ids].id]
  transit_gateway_id                              = aws_ec2_transit_gateway.this[each.value.tgw_name].id
  vpc_id                                          = var.vpc[each.value.vpc_name].id
  transit_gateway_default_route_table_association = lookup(each.value, "transit_gateway_default_route_table_association", false)

  tags = merge(
    {
      Name = format(
        "%s-%s-tgw-%s-attachment",
        var.company,
        var.env,
        each.value.name
      ),
      Env = var.env
    },
  lookup(each.value, "custom_tags", null))
}

# Connect 사용시 주석 해제
# resource "aws_ec2_transit_gateway_connect" "this" {
#   for_each                = { for s_map in var.tgw_create : s_map.name => s_map }
#   transport_attachment_id = aws_ec2_transit_gateway_vpc_attachment.this[each.value.name].id
#   transit_gateway_id      = aws_ec2_transit_gateway.this[each.value.name].id
# }
