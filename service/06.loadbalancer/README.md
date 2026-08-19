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
| <a name="module_lb"></a> [lb](#module\_lb) | ../../modules/loadbalancer | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote_ec2](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_company"></a> [company](#input\_company) | Company Tag | `string` | `"fint"` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment Tag | `string` | `"dr"` | no |
| <a name="input_lb_create"></a> [lb\_create](#input\_lb\_create) | Defined LoadBalancer Infomation | `any` | `[]` | no |
| <a name="input_lb_listener_create"></a> [lb\_listener\_create](#input\_lb\_listener\_create) | Defined LoadBalancer listener Infomation | `any` | `[]` | no |
| <a name="input_lb_listener_rules_create"></a> [lb\_listener\_rules\_create](#input\_lb\_listener\_rules\_create) | Defined LoadBalancer listener rules Infomation | `any` | `[]` | no |
| <a name="input_service"></a> [service](#input\_service) | Service Tag | `string` | `"dmz"` | no |
| <a name="input_tg_create"></a> [tg\_create](#input\_tg\_create) | Defined TargetGroup Infomation | `any` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->