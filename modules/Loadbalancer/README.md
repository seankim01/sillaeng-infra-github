<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_company"></a> [company](#input\_company) | Company Tag | `any` | n/a | yes |
| <a name="input_ec2_info"></a> [ec2\_info](#input\_ec2\_info) | ec2 information | `any` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment Tag | `any` | n/a | yes |
| <a name="input_lb_create"></a> [lb\_create](#input\_lb\_create) | Defined lb configuration option values | `any` | `[]` | no |
| <a name="input_lb_listener_create"></a> [lb\_listener\_create](#input\_lb\_listener\_create) | Defined lb listener configuration option values | `any` | `[]` | no |
| <a name="input_lb_listener_rules_create"></a> [lb\_listener\_rules\_create](#input\_lb\_listener\_rules\_create) | Defined lb listener configuration option values | `any` | `[]` | no |
| <a name="input_service"></a> [service](#input\_service) | Services Tag | `any` | n/a | yes |
| <a name="input_sg_info"></a> [sg\_info](#input\_sg\_info) | security group information | `any` | n/a | yes |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | subnet information | `any` | n/a | yes |
| <a name="input_tg_create"></a> [tg\_create](#input\_tg\_create) | Defined lb configuration option values | `any` | `[]` | no |
| <a name="input_vpc_info"></a> [vpc\_info](#input\_vpc\_info) | vpc information | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->