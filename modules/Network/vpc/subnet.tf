# Subnet
resource "aws_subnet" "this" {
  for_each = { for s_map in var.subnet : s_map.name => s_map }

  vpc_id            = aws_vpc.this[each.value.vpc_name].id
  availability_zone = each.value.zone
  cidr_block        = each.value.cidr
  # AUTO-ASIGN PUBLIC IP
  map_public_ip_on_launch = contains(["true", "false"], lookup(each.value, "map_public_ip_on_launch", null)) && contains(["public"], lookup(each.value, "position", null)) ? each.value.map_public_ip_on_launch : "false"

  tags = merge(
    {
      Name = format(
        "%s-%s-%s-sbn-%s",
        var.company,
        var.env,
        each.value.service,
        each.value.name
      ),
      Env = var.env
    },
  lookup(each.value, "custom_tags", null))
}
