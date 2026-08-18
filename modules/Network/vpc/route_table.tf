resource "aws_route_table" "this" {
  for_each = { for r_map in toset([for _map in var.subnet : tomap({ vpc_name = _map.vpc_name, service = _map.service, position = _map.position })]) : r_map.position => r_map }

  vpc_id = aws_vpc.this[each.value.vpc_name].id

  tags = {
    Name = format(
      "%s-%s-rt-%s",
      var.company,
      var.env,
      each.value.position
    )
    Type = "rt"
    Env  = var.env
  }
}

resource "aws_route_table_association" "this" {
  for_each       = { for s_map in var.subnet : s_map.name => s_map }
  subnet_id      = aws_subnet.this[each.value.name].id
  route_table_id = aws_route_table.this[each.value.position].id
}

resource "aws_route" "this" {
  for_each = {
    for r_map in var.rt_rule_data : join(".", [r_map.position, r_map.vpc, r_map.dst_cidr]) => r_map
    if length(lookup(r_map, "igw", "")) > 0 || 
       length(lookup(r_map, "nat", "")) > 0 || 
       length(lookup(r_map, "tgw", "")) > 0 || 
       (lookup(r_map, "eni", "") != null && lookup(r_map, "eni", "") != "")
  }
  route_table_id = aws_route_table.this[each.value.position].id

  destination_cidr_block = length(regexall("^([0-9]{1,3}.){3}[0-9]{1,3}/(([0-9]|1[0-9]|2[0-8]|3[0-2]))$", each.value.dst_cidr)) > 0 ? each.value.dst_cidr : null

  gateway_id     = length(lookup(each.value, "igw", "")) > 0 ? aws_internet_gateway.this[each.value.igw].id : null
  nat_gateway_id = length(lookup(each.value, "nat", "")) > 0 ? aws_nat_gateway.this[each.value.nat].id : null
  # vpc_endpoint_id          =  #vpc endpoint module에서 gateway type enpoint 생성 후 route table associate
  transit_gateway_id = length(lookup(each.value, "tgw", "")) > 0 ? var.tgw_create[each.value.tgw].id : null
  # vpc_peering_connection_id = length(lookup(each.value, "pcx", "")) > 0 ? var.vpc_peering_info[each.value.pcx].id : null
  # destination_prefix_list_id = 
  network_interface_id = lookup(each.value, "eni", "") != null && lookup(each.value, "eni", "") != "" ? each.value.eni : null
  depends_on           = [aws_route_table.this]

}
