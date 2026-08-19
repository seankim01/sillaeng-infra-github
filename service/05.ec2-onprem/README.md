<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ../../modules/EC2 | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_company"></a> [company](#input\_company) | Company Tag | `string` | `"fint"` | no |
| <a name="input_ec2_create"></a> [ec2\_create](#input\_ec2\_create) | Defined Ec2 Infomation | `any` | `[]` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment Tag | `string` | `"dr"` | no |
| <a name="input_iam_create"></a> [iam\_create](#input\_iam\_create) | Defined iam Infomation | `any` | `[]` | no |
| <a name="input_iam_policy_attach"></a> [iam\_policy\_attach](#input\_iam\_policy\_attach) | Defined iam policy attach Infomation | `any` | `[]` | no |
| <a name="input_iam_policy_create"></a> [iam\_policy\_create](#input\_iam\_policy\_create) | Defined iam policy Infomation | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_info"></a> [ec2\_info](#output\_ec2\_info) | ec2 information map type output. |
<!-- END_TF_DOCS -->