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
variable "nat_create" {
  description = "nat"
}
variable "rt_rule_data" {
  description = "Routing Rule"
}
variable "sg_rule_data" {
  description = "Secuirty Group Rule"
}

variable "tgw_create" {
  description = "tgw info"
}

variable "vpc_endpoint_create" {
  description = "VPC endpoint configuration"
  type        = any
  default     = []
}
