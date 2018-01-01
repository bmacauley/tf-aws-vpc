//
// Module: tf-aws-vpc
//
//  Variables


# aws_vpc - terraform docs
# https://www.terraform.io/docs/providers/aws/r/vpc.html

# aws_vpc_dhcp_options
# https://www.terraform.io/docs/providers/aws/r/vpc_dhcp_options.html

# aws_subnet
# https://www.terraform.io/docs/providers/aws/d/subnet.html

# aws_route_table
# https://www.terraform.io/docs/providers/aws/d/route_table.html

# aws_internet_gateway
# https://www.terraform.io/docs/providers/aws/d/internet_gateway.html

# aws_nat_gateway - terraform docs
# https://www.terraform.io/docs/providers/aws/d/nat_gateway.html

# aws_vpn_gateway
# https://www.terraform.io/docs/providers/aws/d/vpn_gateway.html

# aws_vpc_endpoint
# https://www.terraform.io/docs/providers/aws/d/vpc_endpoint.html

# aws_eip
# https://www.terraform.io/docs/providers/aws/d/eip.html



variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  default     = ""
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = "list"
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = "list"
  default     = []
}

variable "database_subnets" {
  description = "A list of database subnets"
  type        = "list"
  default     = []
}

variable "elasticache_subnets" {
  description = "A list of elasticache subnets"
  type        = "list"
  default     = []
}

variable "create_database_subnet_group" {
  description = "Controls if database subnet group should be created"
  default     = true
}

variable "azs" {
  description = "A list of availability zones in the region"
  type        = "list"
  default     = []
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  default     = true
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  default     = false
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  default     = false
}

variable "reuse_nat_ips" {
  description = "Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable"
  default     = false
}

variable "external_nat_ip_ids" {
  description = "List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips)"
  type        = "list"
  default     = []
}

variable "enable_dynamodb_endpoint" {
  description = "Should be true if you want to provision a DynamoDB endpoint to the VPC"
  default     = false
}

variable "enable_s3_endpoint" {
  description = "Should be true if you want to provision an S3 endpoint to the VPC"
  default     = false
}

variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

variable "enable_vpn_gateway" {
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
  default     = false
}

variable "private_propagating_vgws" {
  description = "A list of VGWs the private route table should propagate"
  type        = "list"
  default     = []
}

variable "public_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate"
  type        = "list"
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = "map"
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = "map"
  default     = {}
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = "map"
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = "map"
  default     = {}
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  type        = "map"
  default     = {}
}

variable "private_route_table_tags" {
  description = "Additional tags for the private route tables"
  type        = "map"
  default     = {}
}

variable "database_subnet_tags" {
  description = "Additional tags for the database subnets"
  type        = "map"
  default     = {}
}

variable "elasticache_subnet_tags" {
  description = "Additional tags for the elasticache subnets"
  type        = "map"
  default     = {}
}

variable "dhcp_options_tags" {
  description = "Additional tags for the DHCP option set"
  type        = "map"
  default     = {}
}

variable "enable_dhcp_options" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  default     = false
}

variable "dhcp_options_domain_name" {
  description = "Specifies DNS name for DHCP options set"
  default     = ""
}

variable "dhcp_options_domain_name_servers" {
  description = "Specify a list of DNS server addresses for DHCP options set, default to AWS provided"
  type        = "list"
  default     = ["AmazonProvidedDNS"]
}

variable "dhcp_options_ntp_servers" {
  description = "Specify a list of NTP servers for DHCP options set"
  type        = "list"
  default     = []
}

variable "dhcp_options_netbios_name_servers" {
  description = "Specify a list of netbios servers for DHCP options set"
  type        = "list"
  default     = []
}

variable "dhcp_options_netbios_node_type" {
  description = "Specify netbios node_type for DHCP options set"
  default     = ""
}
