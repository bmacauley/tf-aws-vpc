#------------------------------------------
# variables.tf
# Module: tf-aws-vpc
#------------------------------------------

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the vpc, to be used on all the resources as identifier"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  # class B
  default = "172.16.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "List of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "database_subnets" {
  description = "List of database subnets inside the VPC"
  type        = list(string)
  default     = []
}


variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "create_nat_instance" {
  description = "Set to true if you want your private networks to reach the internet"
  type        = bool
  default     = false
}

variable "nat_instance_type" {
  description = "Amazon linux instance type for NAT instance. The instance type affects the network performace (and cost). See the link in vpc.tf"
  type        = string
  default     = "t4g.nano"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}
