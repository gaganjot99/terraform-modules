variable "instance_type" {
  default = {
    "prod" = "t2.micro"
    "test" = "t2.micro"
    "dev"  = "t2.micro"
  }
  description = "Type of the instance"
  type        = map(string)
}

variable "public_subnet_ids" {
  default     = []
  type        = list(string)
  description = "Public Subnet ids"
}

variable "private_subnet_ids" {
  default     = []
  type        = list(string)
  description = "Private Subnet ids"
}

variable "public_sgs_ids" {
  default     = []
  type        = list(string)
  description = "security group ids for public instances"
}

variable "private_sgs_ids" {
  default     = []
  type        = list(string)
  description = "security group ids for private instances"
}

variable "key_name" {
  type        = string
  description = "key name for the instances"
}

# Default tags
variable "default_tags" {
  default = {
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Prefix to identify resources
variable "prefix" {
  default     = "gagan"
  type        = string
  description = "Name prefix"
}


# Variable to signal the current environment 
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}