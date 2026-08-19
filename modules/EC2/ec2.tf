resource "aws_instance" "this" {
  for_each               = { for _map in var.ec2_create : _map.index => _map }
  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  subnet_id              = each.value.eni_required ? null : var.subnet_info[each.value.sub_index].id
  vpc_security_group_ids = each.value.eni_required ? null : [for sg_ids in each.value.sg_index : var.sg_info[sg_ids].id]
  key_name               = lookup(each.value, "key_name", null)
  iam_instance_profile   = lookup(each.value, "instance_profile_index", null) == null ? null : aws_iam_instance_profile.ec2_profile[each.value.instance_profile_index].name
  source_dest_check      = each.value.eni_required ? null : lookup(each.value, "source_dest_check", null)
  user_data              = lookup(each.value, "user_data", null) == null ? null : file(each.value.user_data)

  root_block_device {
    volume_size = lookup(each.value, "volume_size", null)
    volume_type = lookup(each.value, "volume_type", null)
  }

  dynamic "instance_market_options" {
    for_each = lookup(each.value, "spot_enabled", false) ? [1] : []
    content {
      market_type = "spot"
      spot_options {
        instance_interruption_behavior = lookup(each.value, "spot_interruption_behavior", "stop")
        spot_instance_type             = lookup(each.value, "spot_instance_type", "persistent")
        max_price                      = lookup(each.value, "spot_max_price", null)
      }
    }
  }

  dynamic "network_interface" {
    for_each = each.value.eni_required ? [1] : []
    content {
      network_interface_id = aws_network_interface.this[each.value.index].id
      device_index         = lookup(each.value, "device_index", 0)
    }
  }

  tags = merge(
    lookup(each.value, "custom_tags", null),
    {
      NetworkBoundary = each.value.network_boundary
      Type            = each.value.type
      Purpose         = each.value.purpose
      Env             = var.env
      Name = join("-",
        [var.company,
          var.env,
          each.value.service,
          each.value.type,
          each.value.purpose
      ])
  })
  depends_on = [aws_network_interface.this]
}

resource "aws_network_interface" "this" {
  for_each          = { for _map in var.ec2_create : _map.index => _map if lookup(_map, "eni_required", false) }
  subnet_id         = var.subnet_info[each.value.sub_index].id
  private_ips       = [each.value.private_ips]
  security_groups   = [for sg_ids in each.value.sg_index : var.sg_info[sg_ids].id]
  source_dest_check = lookup(each.value, "source_dest_check", true)

  tags = merge(
    lookup(each.value, "custom_tags", null),
    {
      NetworkBoundary = each.value.network_boundary
      Type            = each.value.type
      Purpose         = each.value.purpose
      Env             = var.env
      Name = join("-",
        [var.company,
          var.env,
          each.value.service,
          each.value.type,
          each.value.purpose,
          "eni"
      ])
  })

}

# instance type, ami, vpc, subnet, eip , key pair, IAM 없음 , 보안그룹 , 퍼블릭 DNS 할당, 스토리지는 root만..

# 새 EIP 생성 (eip_allocation_id 미지정 시)
resource "aws_eip" "ec2" {
  for_each = { for _map in var.ec2_create : _map.index => _map if lookup(_map, "eip_required", false) && lookup(_map, "eip_allocation_id", null) == null }
  domain   = "vpc"
  instance = aws_instance.this[each.value.index].id

  tags = merge(
    {
      NetworkBoundary = each.value.network_boundary
      Type            = "eip"
      Purpose         = each.value.purpose
      Env             = var.env
      Name = join("-",
        [var.company,
          var.env,
          each.value.service,
          "eip",
          each.value.purpose
      ])
  })
}

# 기존 예약된 EIP 연결 (eip_allocation_id 지정 시)
resource "aws_eip_association" "ec2" {
  for_each      = { for _map in var.ec2_create : _map.index => _map if lookup(_map, "eip_required", false) && lookup(_map, "eip_allocation_id", null) != null }
  instance_id   = each.value.eni_required ? null : aws_instance.this[each.value.index].id
  allocation_id = each.value.eip_allocation_id
  network_interface_id = each.value.eni_required ? aws_network_interface.this[each.value.index].id : null
}

