# tag
variable "company" {
  description = "Company Tag"
  default     = "sillaeng"
}
variable "env" {
  description = "Environment Tag"
  default     = "demo"
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

variable "vpc_endpoint_create" {
  description = "Defined VPC endpoint configuration option values"
  type        = any
  default     = []
}
