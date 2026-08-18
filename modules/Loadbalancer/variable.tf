# tag
variable "company" {
  description = "Company Tag"
  type        = any
}
variable "env" {
  description = "Environment Tag"
  type        = any
}
variable "service" {
  description = "Services Tag"
  type        = any
}
variable "ec2_info" {
  description = "ec2 information"
  type        = any
}

variable "vpc_info" {
  description = "vpc information"
  type        = any
}

variable "sg_info" {
  description = "security group information"
  type        = any
}

variable "subnet_info" {
  description = "subnet information"
  type        = any
}

variable "lb_create" {
  description = "Defined lb configuration option values"
  type        = any
  default     = []
}

variable "lb_listener_create" {
  description = "Defined lb listener configuration option values"
  type        = any
  default     = []
}

variable "lb_listener_rules_create" {
  description = "Defined lb listener configuration option values"
  type        = any
  default     = []
}

variable "tg_create" {
  description = "Defined lb configuration option values"
  type        = any
  default     = []
}
