resource "aws_ec2_transit_gateway_route_table" "this" {
  for_each           = { for s_map in var.tgw_rtb_create : s_map.name => s_map }
  transit_gateway_id = aws_ec2_transit_gateway.this[each.value.tgw].id

  tags = merge(
    {
      Name = format(
        "%s-%s-tgw-rtb-%s",
        var.company,
        var.env,
        each.value.name
      ),
      Env = var.env
    },
  lookup(each.value, "custom_tags", null))
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  for_each                       = { for s_map in var.tgw_rtb_association_create : s_map.name => s_map }
  transit_gateway_attachment_id  = each.value.vpn_required ? aws_vpn_connection.this[each.value.tgw_att].transit_gateway_attachment_id : aws_ec2_transit_gateway_vpc_attachment.this[each.value.tgw_att].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this[each.value.rtb].id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  for_each                       = { for s_map in var.tgw_rtb_association_create : s_map.name => s_map }
  transit_gateway_attachment_id  = each.value.vpn_required ? aws_vpn_connection.this[each.value.tgw_att].transit_gateway_attachment_id : aws_ec2_transit_gateway_vpc_attachment.this[each.value.tgw_att].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this[each.value.rtb].id
}

resource "aws_ec2_transit_gateway_route" "this" {
  for_each                       = { for s_map in var.tgw_route_create : s_map.name => s_map }
  destination_cidr_block         = each.value.destination_cidr_block
  transit_gateway_attachment_id  = each.value.vpn_required ? aws_vpn_connection.this[each.value.tgw_att].transit_gateway_attachment_id : aws_ec2_transit_gateway_vpc_attachment.this[each.value.tgw_att].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this[each.value.tgw_rtb].id
}
