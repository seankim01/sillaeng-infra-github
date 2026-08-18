# IGW
resource "aws_internet_gateway" "this" {
  for_each = { for _map in var.vpc : _map.vpc_name => _map if lookup(_map, "aws_internet_gateway", false) }
  vpc_id   = aws_vpc.this[each.value.vpc_name].id

  tags = {
    Name = format(
      "%s-%s-%s-igw",
      var.company,
      var.env,
      each.value.service
    )
    Env  = var.env
    Type = "igw"
  }

}

# Elastic IP for Public NAT Gateway
# - connectivity_type = "public" or null/not set: Public NAT Gateway (single-AZ, EIP required)
# - connectivity_type = "private": Regional NAT Gateway (multi-AZ, EIP not required)
# - availability_mode = "regional": Regional mode may require EIPs for each AZ
resource "aws_eip" "this" {
  for_each = { 
    for _map in var.nat_create : _map.index => _map 
    if lookup(_map, "connectivity_type", "public") != "private"
  }
  domain   = "vpc"

  tags = {
    Name = format(
      "%s-%s-%s-%s-eip",
      var.company,
      var.env,
      each.value.service,
      each.value.type
    )
    Env            = var.env
    Type           = "eip"
    NetworkBoudary = each.value.networkboudary
  }
}

# Note: When eip_allocation_method = "automatic" and availability_mode = "regional",
# AWS automatically manages EIPs, so we don't need to create separate EIP resources.
# EIP resources are only needed when eip_allocation_method = "manual" and you want to pre-create EIPs.
# For automatic mode, AWS handles EIP allocation internally.

# NAT Gateway
# - connectivity_type = "private": Regional NAT Gateway (multi-AZ, no EIP required)
# - connectivity_type = "public" or null/not set: Public NAT Gateway (single-AZ, EIP required)
# - availability_mode = "regional": Regional availability mode (multi-AZ, requires availability_zone_address)
# - availability_mode = "zonal" or null/not set: Zonal availability mode (single-AZ, requires subnet_id)
# Note: availability_mode requires AWS Provider v6.24.0 or later
# Reference: https://github.com/hashicorp/terraform-provider-aws/issues/45151
resource "aws_nat_gateway" "this" {
  for_each = { for _map in var.nat_create : _map.index => _map }
  
  # Regional NAT Gateway (connectivity_type = "private") does not use allocation_id
  # Public NAT Gateway (connectivity_type = "public" or null) requires allocation_id (Elastic IP)
  # For zonal mode, use the main EIP
  allocation_id = lookup(each.value, "connectivity_type", "public") == "private" ? null : (
    lookup(each.value, "availability_mode", "zonal") == "zonal" ? try(aws_eip.this[each.value.index].id, null) : null
  )
  
  # subnet_id is required for zonal mode
  # For regional mode with regional_nat_gateway_auto_mode, subnet_id is not required
  # For regional mode with availability_zone_addresses, subnet_id is optional
  subnet_id = lookup(each.value, "availability_mode", "zonal") == "regional" ? (
    lookup(each.value, "availability_zone_addresses", null) != null ? try(aws_subnet.this[each.value.sub_index].id, null) : null
  ) : try(aws_subnet.this[each.value.sub_index].id, null)
  
  # vpc_id is required for regional mode
  # Get VPC ID from the subnet referenced by sub_index
  vpc_id = lookup(each.value, "availability_mode", "zonal") == "regional" ? try(aws_subnet.this[each.value.sub_index].vpc_id, null) : null
  
  connectivity_type = lookup(each.value, "connectivity_type", null)
  
  # availability_mode: "zonal" (default) or "regional"
  # Requires AWS Provider v6.24.0+ (milestone: v6.24.0)
  # If not supported, this attribute will be ignored
  availability_mode = lookup(each.value, "availability_mode", null)

  # Availability zone addresses for regional mode
  # When availability_mode = "regional" and connectivity_type = "public", use EIPs
  # - eip_allocation_method = "automatic": Do NOT create availability_zone_address block (AWS handles EIP allocation automatically)
  # - eip_allocation_method = "manual": Must provide availability_zone_addresses with existing EIP allocation IDs
  #   When availability_zone_addresses is provided, AWS uses manual mode
  #   When availability_zone_addresses is NOT provided, AWS uses automatic mode
  dynamic "availability_zone_address" {
    # Only create availability_zone_address block when:
    # 1. availability_mode = "regional"
    # 2. availability_zone_addresses is explicitly provided (eip_allocation_method = "manual")
    # Do NOT create this block when eip_allocation_method = "automatic" to let AWS use automatic mode
    for_each = (lookup(each.value, "availability_mode", null) == "regional" && lookup(each.value, "availability_zone_addresses", null) != null) ? each.value.availability_zone_addresses : []
    content {
      allocation_ids  = lookup(availability_zone_address.value, "allocation_ids", null) != null ? availability_zone_address.value.allocation_ids : (
        lookup(availability_zone_address.value, "allocation_id", null) != null ? [availability_zone_address.value.allocation_id] : null
      )
      availability_zone = availability_zone_address.value.availability_zone
    }
  }
  
  # Validation: If eip_allocation_method = "manual" and availability_mode = "regional" and connectivity_type = "public",
  # availability_zone_addresses must be provided
  # Note: This is a pre-apply validation check
  lifecycle {
    precondition {
      condition = !(
        lookup(each.value, "availability_mode", null) == "regional" 
        && lookup(each.value, "connectivity_type", "public") == "public"
        && lookup(each.value, "eip_allocation_method", "automatic") == "manual"
        && lookup(each.value, "availability_zone_addresses", null) == null
      )
      error_message = "When eip_allocation_method = 'manual' and availability_mode = 'regional' and connectivity_type = 'public', you must provide availability_zone_addresses with existing EIP allocation IDs. Otherwise AWS will use automatic mode."
    }
  }

  tags = {
    Name = format(
      "%s-%s-%s-%s",
      var.company,
      var.env,
      each.value.service,
      each.value.index
    )
    Env            = var.env
    Type           = each.value.type
    NetworkBoudary = each.value.networkboudary
  }
}


