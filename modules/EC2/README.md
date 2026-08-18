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
| [aws_eip.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_instance_profile.ec2_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_network_interface.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_company"></a> [company](#input\_company) | Company Tag | `any` | n/a | yes |
| <a name="input_ec2_create"></a> [ec2\_create](#input\_ec2\_create) | Defined bastion ec2 configuration option values | `any` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment Tag | `any` | n/a | yes |
| <a name="input_iam_create"></a> [iam\_create](#input\_iam\_create) | Defined iam role configuration option values | `any` | `[]` | no |
| <a name="input_iam_policy_attach"></a> [iam\_policy\_attach](#input\_iam\_policy\_attach) | Defined iam policy role attach configuration option values | `any` | `[]` | no |
| <a name="input_iam_policy_create"></a> [iam\_policy\_create](#input\_iam\_policy\_create) | Defined iam policy configuration option values | `any` | `[]` | no |
| <a name="input_sg_info"></a> [sg\_info](#input\_sg\_info) | security group information | `any` | n/a | yes |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | subnet information | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_info"></a> [ec2\_info](#output\_ec2\_info) | n/a |
<!-- END_TF_DOCS -->