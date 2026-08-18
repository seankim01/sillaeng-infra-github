# Security Gruop
resource "aws_security_group" "this" {
  for_each = { for s_map in toset(distinct([for index, rule in var.sg_rule_data : tomap({ rulename = rule.name, purpose = rule.purpose, vpc = rule.vpc, position = rule.position, service = rule.service })])) : s_map.rulename => s_map }

  name        = join("-", [var.company, var.env, "sg", each.value.purpose]) ## 
  vpc_id      = aws_vpc.this[each.value.vpc].id
  description = join(" ", [var.env, "vpc", each.value.purpose, "security group"])

  tags = {
    Type = "sg"
    Env  = var.env
    Name = join("-", [
      var.company,
      var.env,
      each.value.service,
      "sg",
      each.value.purpose
    ])
  }
  lifecycle {
    ignore_changes = [name, description, tags]
  }

  depends_on = [
    aws_vpc.this
  ]
}

#Security Group Rule
resource "aws_security_group_rule" "this" {
  for_each = { for s_map in var.sg_rule_data : join(".", [s_map.name, s_map.vpc, s_map.type, s_map.from_port, s_map.to_port, s_map.protocol, s_map.source, s_map.src_sg]) => s_map }

  type                     = each.value.type
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = length(regexall("^([0-9]{1,3}.){3}[0-9]{1,3}/(([0-9]|1[0-9]|2[0-8]|3[0-2]))$", each.value.source)) > 0 ? [each.value.source] : null
  self                     = each.value.source == "self" ? true : null
  prefix_list_ids          = substr(each.value.source, 0, 2) == "pl" ? [each.value.source] : null
  source_security_group_id = lookup(each.value, "src_sg", null) == "" ? null : aws_security_group.this[each.value.src_sg].id
  description              = each.value.description
  security_group_id        = aws_security_group.this[each.value.name].id
}
