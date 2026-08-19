# tag
variable "company" {
  description = "Company Tag"
  type        = string
  default     = "sillaeng"
}
variable "env" {
  description = "Environment Tag"
  type        = string
  default     = "idc"
}

variable "ec2_create" {
  description = "Defined Ec2 Infomation"
  type        = any
  default     = []
}

variable "iam_create" {
  description = "Defined iam Infomation"
  type        = any
  default     = []
}

variable "iam_policy_create" {
  description = "Defined iam policy Infomation"
  type        = any
  default     = []
}

variable "iam_policy_attach" {
  description = "Defined iam policy attach Infomation"
  type        = any
  default     = []
}
