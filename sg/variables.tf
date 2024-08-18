variable "vpc_id" {
    type = string
    description = "vpc id for the security groups"
}

variable "default_tags" {
  default     = {}
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

variable "prefix" {
  default = "group3"
  type        = string
  description = "Name prefix"
}