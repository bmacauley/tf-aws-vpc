#-----------------------------------
# variables.tf
#-----------------------------------

# common variables for every module
variable "tags" {
  description = "Common set of tags."
  type        = map(string)
  default     = {}
}

# module specific variables
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

variable "azs" {
  description = "A list of availability zones names or ids in the region. If empty, defaults to first three available zones."
  type        = list(string)
  default     = []
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

variable "create_database_subnet_route_table" {
  description = "Controls if separate route table for database should be created"
  type        = bool
  default     = true
}
variable "create_database_subnet_group" {
  description = "Controls if database subnet group should be created (n.b. database_subnets must also be set)"
  type        = bool
  default     = true
}
variable "create_database_internet_gateway_route" {
  description = "Controls if an internet gateway route for public database access should be created"
  type        = bool
  default     = false
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

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  type        = bool
  default     = false
}

variable "enable_dhcp_options" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  type        = bool
  default     = false
}

variable "dhcp_options_domain_name" {
  description = "Specifies DNS name for DHCP options set (requires enable_dhcp_options set to true)"
  type        = string
  default     = ""
}

variable "enable_flow_log" {
  description = "enable vpc flow logs"
  type        = bool
  default     = false
}

variable "map_public_ip_on_launch" {
  description = "Should be true if you want to auto-assign public IP on launch"
  type        = bool
  default     = false
}

variable "enable_vpc_endpoints" {
  description = "enable vpc endpoints"
  type        = map(any)
  default = {
    s3       = true
    dynamodb = true
  }
}

 variable "create_nat_instance" {
     description = "Set to true if you want your private networks to reach the internet"
     type = bool
     default = false
 }

 variable "nat_instance_type" {
     description = "Amazon linux instance type for NAT instance. The instance type affects the network performace (and cost). See the link in vpc.tf"
     type        = string
     default     = "t3.nano"
 }

