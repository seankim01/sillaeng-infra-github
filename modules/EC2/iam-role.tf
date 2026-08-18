#IAM
resource "aws_iam_role" "ec2" {
  for_each           = { for _map in var.iam_create : _map.index => _map }
  name               = join("-", [var.company, var.env, each.value.purpose, "ec2Role"])
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

  tags = merge(
    lookup(each.value, "custom_tags", null),
    {
      Type = "role"
      Env  = var.env
      Name = join("-",
        [var.company,
          var.env,
          each.value.purpose,
      "ec2Role"])
  })

}

resource "aws_iam_policy" "policy" {
  for_each    = { for _map in var.iam_policy_create : _map.index => _map }
  name        = join("-", [var.company, var.env, each.value.purpose, "ec2RolePolicy"])
  description = lookup(each.value, "policy_description", null)
  policy      = file("${each.value.policy}")

  tags = merge(
    lookup(each.value, "custom_tags", null),
    {
      Type = "policy"
      Env  = var.env
      Name = join("-",
        [var.company,
          var.env,
          each.value.purpose,
      "ec2RolePolicy"])
  })

}

resource "aws_iam_role_policy_attachment" "attach" {
  for_each   = { for _map in var.iam_policy_attach : _map.index => _map }
  policy_arn = lookup(each.value, "custom_policy_index", null) == null ? lookup(each.value, "policy_arn", null) : aws_iam_policy.policy[each.value.custom_policy_index].arn
  role       = aws_iam_role.ec2[each.value.iam_index].name
}

resource "aws_iam_instance_profile" "ec2_profile" {
  for_each = { for _map in var.iam_create : _map.index => _map }
  name     = join("-", [var.company, var.env, "iam", "ec2InstanceProfile"])
  role     = aws_iam_role.ec2[each.value.index].name

  tags = merge(
    {
      Env = var.env
      Name = join("-",
        [var.company,
          var.env,
      "ec2InstanceProfile"])
  })
}
