# VPC Endpoints
# Gateway endpoints (S3, DynamoDB) - automatically adds routes to route tables
# Interface endpoints (SSM, SSM Messages, EC2 Messages) - requires subnets and security groups

# Gateway Endpoints (S3, DynamoDB)
resource "aws_vpc_endpoint" "gateway" {
  for_each = {
    for ep in var.vpc_endpoint_create : ep.index => ep
    if lookup(ep, "vpc_endpoint_type", null) == "Gateway"
  }

  vpc_id            = aws_vpc.this[each.value.vpc_name].id
  vpc_endpoint_type = "Gateway"
  service_name      = each.value.service_name

  # Route table IDs for gateway endpoints
  route_table_ids = [
    for rt_position in lookup(each.value, "route_table_positions", []) :
    aws_route_table.this[rt_position].id
  ]

  tags = {
    Name = format(
      "%s-%s-%s-ep-%s",
      var.company,
      var.env,
      each.value.service,
      each.value.index
    )
    Env  = var.env
    Type = "vpc-endpoint"
  }
}

# Interface Endpoints (SSM, SSM Messages, EC2 Messages, etc.)
resource "aws_vpc_endpoint" "interface" {
  for_each = {
    for ep in var.vpc_endpoint_create : ep.index => ep
    if lookup(ep, "vpc_endpoint_type", null) == "Interface"
  }

  vpc_id              = aws_vpc.this[each.value.vpc_name].id
  vpc_endpoint_type   = "Interface"
  service_name        = each.value.service_name
  subnet_ids          = [for sub_name in lookup(each.value, "subnet_names", []) : aws_subnet.this[sub_name].id]
  security_group_ids  = [for sg_name in lookup(each.value, "security_group_names", []) : aws_security_group.this[sg_name].id]
  private_dns_enabled = lookup(each.value, "private_dns_enabled", true)

  tags = {
    Name = format(
      "%s-%s-%s-ep-%s",
      var.company,
      var.env,
      each.value.service,
      each.value.index
    )
    Env  = var.env
    Type = "vpc-endpoint"
  }
}
