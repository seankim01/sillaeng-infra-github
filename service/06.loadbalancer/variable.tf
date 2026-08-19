# tag
variable "company" {
  description = "Company Tag"
  type        = string
  default     = "sillaeng"
}
variable "env" {
  description = "Environment Tag"
  type        = string
  default     = "demo"
}
variable "service" {
  description = "Service Tag"
  type        = string
  default     = "service"
}

variable "lb_create" {
  description = "Defined LoadBalancer Infomation"
  type        = any
  default     = []
}

variable "tg_create" {
  description = "Defined TargetGroup Infomation"
  type        = any
  default     = []
}

variable "lb_listener_create" {
  description = "Defined LoadBalancer listener Infomation"
  type        = any
  default     = []
}

variable "lb_listener_rules_create" {
  description = "Defined LoadBalancer listener rules Infomation"
  type        = any
  default     = []
}
