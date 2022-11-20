#-----------------------------------
# variables.tf
#----------------------------------


# variable "amazon_ec2_linux_image" {
#   description = "Amazon linux image for NAT instance."
#   type        = string
#   default     = "amzn2-ami-kernel-5.10-hvm-*"
# }

# variable "amazon_ec2_instance_virtualization_type" {
#   description = "Amazon linux image for NAT instance."
#   type        = string
#   default     = "hvm"
# }

# amazon linux AMI owner
# variable "amazon_owner_id" {
#   description = "Amazon owner id."
#   type        = string
#   default     = "137112412989"
# }

# variable "ssm_agent_policy" {
#   description = "Policy of SSM agent."
#   type        = string
#   default     = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
# }

// Shared variables.
variable "name" {
  description = "Name of the vpc, to be used on all the resources as identifier"
  type        = string
}

variable "aws_vpc_id" { type = string }
variable "nat_instance_type" {
  type = string
  default = "t4g.nano"
}
variable "private_subnets_ids" {}
variable "public_subnets_ids" {}
