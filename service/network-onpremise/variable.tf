# tag
variable "company" {
  description = "Company Tag"
  default     = "hsfms"
}
variable "env" {
  description = "Environment Tag"
  default     = "idc"
}

variable "vpc" {
  description = "Defined VPC configuration option values"
  type        = any
}

variable "subnet" {
  description = "Defined subnet configuration option values"
  type        = any
}

variable "nat_create" {
  description = "Defined nat configuration option values"
  type        = any
  default     = []
}
variable "tgw_create" {
  description = "Defined tgw configuration option values"
  type        = any
  default     = []
}
variable "tgw_att_create" {
  description = "Defined tgw attachment configuration option values"
  type        = any
  default     = []
}

variable "tgw_rtb_association_create" {
  description = "Defined tgw rtb configuration option values"
  type        = any
  default     = []
}

variable "tgw_rtb_create" {
  description = "Defined tgw rtb configuration option values"
  type        = any
  default     = []
}

variable "tgw_route_create" {
  description = "Defined tgw route configuration option values"
  type        = any
  default     = []
}
variable "cgw" {
  description = "Defined CGW configuration option values"
  type        = any
  default     = []
}
variable "vpn" {
  description = "Defined Site to Site VPN configuration option values"
  type        = any
  default     = []
}
