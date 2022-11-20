#-----------------------------------------
# locals.tf
# - module local variables
#-----------------------------------------
locals {
  aws_account_alias = data.aws_iam_account_alias.current.account_alias                                # ori001
  aws_region_short  = join("", [for r in split("-", data.aws_region.current.name) : substr(r, 0, 1)]) # eu-west-2 --> ew2


  common_tags = {
    managed_by = "terraform"
  }


  # vpc configuration
  create_vpc = var.create_vpc
  name       = var.name
  cidr       = var.cidr
  azs = length(var.azs) != 0 ? var.azs : [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1],
    data.aws_availability_zones.available.names[2]
  ]


  ### public subnets
  public_subnets          = var.public_subnets
  map_public_ip_on_launch = var.map_public_ip_on_launch

  ### private subnets
  private_subnets = var.private_subnets

  ### database subnets
  database_subnets                       = var.database_subnets
  create_database_subnet_route_table     = var.create_database_subnet_route_table
  create_database_subnet_group           = var.create_database_subnet_group
  create_database_internet_gateway_route = var.create_database_internet_gateway_route


  ### enable dns
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  ### nat gateway config
  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  ### nat gateway config
  create_nat_instance     = var.create_nat_instance
  nat_instance_type       = var.nat_instance_type

  ### enable endpoints
  enable_vpc_endpoints_defaults = {
    s3       = true
    dynamodb = true
  }


  enable_vpc_endpoints = merge(local.enable_vpc_endpoints_defaults, var.enable_vpc_endpoints)
  ### enable vpc flowlogs
  enable_flow_log           = var.enable_flow_log
  flow_log_destination_type = "s3"
  vpc_flow_log_bucket_name  = "vpc-${var.name}-flow-logs-${local.aws_region_short}-${local.aws_account_alias}"

  tags = merge(var.tags, local.common_tags)

}
