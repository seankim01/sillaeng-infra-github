<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network"></a> [network](#module\_network) | ../../modules/1. Network/vpc | n/a |
| <a name="module_tgw"></a> [tgw](#module\_tgw) | ../../modules/1. Network/tgw | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cgw"></a> [cgw](#input\_cgw) | Defined CGW configuration option values | `any` | `[]` | no |
| <a name="input_company"></a> [company](#input\_company) | Company Tag | `string` | `"hsfms"` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment Tag | `string` | `"dr"` | no |
| <a name="input_nat_create"></a> [nat\_create](#input\_nat\_create) | Defined nat configuration option values | `any` | `[]` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | Defined subnet configuration option values | `any` | n/a | yes |
| <a name="input_tgw_att_create"></a> [tgw\_att\_create](#input\_tgw\_att\_create) | Defined tgw attachment configuration option values | `any` | `[]` | no |
| <a name="input_tgw_create"></a> [tgw\_create](#input\_tgw\_create) | Defined tgw configuration option values | `any` | `[]` | no |
| <a name="input_tgw_route_create"></a> [tgw\_route\_create](#input\_tgw\_route\_create) | Defined tgw route configuration option values | `any` | `[]` | no |
| <a name="input_tgw_rtb_association_create"></a> [tgw\_rtb\_association\_create](#input\_tgw\_rtb\_association\_create) | Defined tgw rtb configuration option values | `any` | `[]` | no |
| <a name="input_tgw_rtb_create"></a> [tgw\_rtb\_create](#input\_tgw\_rtb\_create) | Defined tgw rtb configuration option values | `any` | `[]` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | Defined VPC configuration option values | `any` | n/a | yes |
| <a name="input_vpn"></a> [vpn](#input\_vpn) | Defined Site to Site VPN configuration option values | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sg_info"></a> [sg\_info](#output\_sg\_info) | sg information map type output. |
| <a name="output_subnet_info"></a> [subnet\_info](#output\_subnet\_info) | subnet information map type output. |
| <a name="output_tgw_info"></a> [tgw\_info](#output\_tgw\_info) | tgw information map type output. |
| <a name="output_vpc_info"></a> [vpc\_info](#output\_vpc\_info) | vpc information map type output. |
<!-- END_TF_DOCS -->