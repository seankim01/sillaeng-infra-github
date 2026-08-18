resource "aws_flow_log" "this" {
  for_each        = { for _map in var.vpc : _map.vpc_name => _map if lookup(_map, "flowlog", false) }
  iam_role_arn    = aws_iam_role.flowlog[each.value.vpc_name].arn
  log_destination = aws_cloudwatch_log_group.this[each.value.vpc_name].arn
  traffic_type    = each.value.flowlog_type
  vpc_id          = aws_vpc.this[each.value.vpc_name].id


  depends_on = [aws_cloudwatch_log_group.this]
  tags = {
    Name = format(
      "%s-%s-%s-%s",
      var.company,
      var.env,
      each.value.service,
      "vpc-flowlogs"
    ),
    Env = var.env
  }
}

resource "aws_cloudwatch_log_group" "this" {
  for_each          = { for _map in var.vpc : _map.vpc_name => _map if lookup(_map, "flowlog", false) }
  name              = lower(join("-", [var.company, var.env, "vpc", "flowlog"]))
  skip_destroy      = false
  retention_in_days = lookup(each.value, "log_retention", 7)
  kms_key_id        = lookup(each.value, "log_kms_key", null)

  lifecycle {
    ignore_changes = [
      retention_in_days,
      kms_key_id
    ]
  }
  tags = {
    Name = format(
      "%s-%s-%s-%s-%s",
      var.company,
      var.env,
      each.value.service,
      each.value.vpc_name,
      "flowlog"
    ),
    Env = var.env
  }
}

resource "aws_iam_role" "flowlog" {
  for_each           = { for _map in var.vpc : _map.vpc_name => _map if lookup(_map, "flowlog", false) }
  name               = lower(join("-", [var.company, var.env, "iam-role", "vpc", "flowlog"]))
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "vpc-flow-logs.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

  tags = {
    Name = format(
      "%s-%s-%s-%s-%s-%s",
      var.company,
      var.env,
      each.value.service,
      "iam-role",
      each.value.vpc_name,
      "flowlog"
    ),
    Env = var.env
  }
}

resource "aws_iam_policy" "flowlog" {
  for_each    = { for _map in var.vpc : _map.vpc_name => _map if lookup(_map, "flowlog", false) }
  name        = lower(join("-", [var.company, var.env, "iam-policy", "vpc", "flowlog"]))
  path        = "/"
  description = "VPC Flowlog policy for VPC"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams"
            ],
          "Resource": [
              "*"
            ]
      }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach" {
  for_each   = { for _map in var.vpc : _map.vpc_name => _map if lookup(_map, "flowlog", false) }
  policy_arn = aws_iam_policy.flowlog[each.value.vpc_name].arn
  role       = aws_iam_role.flowlog[each.value.vpc_name].name
}
