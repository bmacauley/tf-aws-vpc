#-----------------------------------
# variables.tf
#----------------------------------


# Shared variables.
variable "name" {
  description = "Name of the vpc, to be used on all the resources as identifier"
  type        = string
}

variable "aws_vpc_id" {
  description = "aws vpc id"
  type        = string
}
variable "nat_instance_type" {
  description = "nat intsance type"
  type        = string
  default     = "t4g.nano"
}

variable "public_subnets_ids" {
  description = "public subnet ids"
  type        = list(any)
}
