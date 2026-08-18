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
| [aws_customer_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_ec2_tag.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_transit_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) | resource |
| [aws_ec2_transit_gateway_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_vpn_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cgw"></a> [cgw](#input\_cgw) | Customer Gateway | `any` | n/a | yes |
| <a name="input_company"></a> [company](#input\_company) | Company Tag | `any` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment Tag | `any` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | Subnet | `any` | n/a | yes |
| <a name="input_tgw_att_create"></a> [tgw\_att\_create](#input\_tgw\_att\_create) | Transit Attachment | `any` | n/a | yes |
| <a name="input_tgw_create"></a> [tgw\_create](#input\_tgw\_create) | Transit Gateway | `any` | n/a | yes |
| <a name="input_tgw_route_create"></a> [tgw\_route\_create](#input\_tgw\_route\_create) | Transit Gateway route | `any` | n/a | yes |
| <a name="input_tgw_rtb_association_create"></a> [tgw\_rtb\_association\_create](#input\_tgw\_rtb\_association\_create) | Transit Gateway associate RouteTable | `any` | n/a | yes |
| <a name="input_tgw_rtb_create"></a> [tgw\_rtb\_create](#input\_tgw\_rtb\_create) | Transit Gateway RouteTable | `any` | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | VPC | `any` | n/a | yes |
| <a name="input_vpn"></a> [vpn](#input\_vpn) | AWS Site to Site VPN | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tgw_info"></a> [tgw\_info](#output\_tgw\_info) | n/a |
| <a name="output_vpn_info"></a> [vpn\_info](#output\_vpn\_info) | n/a |
<!-- END_TF_DOCS -->