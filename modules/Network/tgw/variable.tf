# tag
variable "company" {
  description = "Company Tag"
}
variable "env" {
  description = "Environment Tag"
}

variable "vpc" {
  description = "VPC"
}
variable "subnet" {
  description = "Subnet"
}

variable "tgw_create" {
  description = "Transit Gateway"
}
variable "tgw_att_create" {
  description = "Transit Attachment"
}
variable "tgw_rtb_create" {
  description = "Transit Gateway RouteTable"
}
variable "tgw_rtb_association_create" {
  description = "Transit Gateway associate RouteTable"
}

variable "tgw_route_create" {
  description = "Transit Gateway route"
}

# 사용 시 주석 해제
variable "cgw" {
  description = "Customer Gateway"
}
variable "vpn" {
  description = "AWS Site to Site VPN"
}
