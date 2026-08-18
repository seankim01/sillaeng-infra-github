###########################################
# VPC
###########################################
resource "aws_vpc" "this" {
  for_each                         = { for s_map in var.vpc : s_map.vpc_name => s_map }
  cidr_block                       = each.value.cidr_block
  enable_dns_hostnames             = each.value.enable_dns_hostnames
  enable_dns_support               = each.value.enable_dns_support
  assign_generated_ipv6_cidr_block = each.value.enable_ipv6

  tags = {
    Name = format(
      "%s-%s-%s-vpc",
      var.company,
      var.env,
      each.value.service
    ),
    Env = var.env
  }
}
