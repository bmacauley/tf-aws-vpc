provider "aws" {
  region = "eu-west-1"
}


# Get AWS AZ zones
data "aws_availability_zones" "available" {}



locals {
  create_vpc = var.create_vpc
  name       = var.name
  azs = [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1],
    data.aws_availability_zones.available.names[2]
  ]
  cidr               = var.cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  database_subnets   = var.database_subnets
  enable_nat_gateway = var.enable_nat_gateway
  tags = {
    managed_by = "terraform"
  }
}

module "vpc" {
  source = "../../"

  create_vpc = local.create_vpc

  name = local.name
  cidr = local.cidr
  azs  = local.azs

  ### public subnets
  public_subnets = local.public_subnets

  ### private subnets
  private_subnets = local.private_subnets

  ### database subnets
  database_subnets = local.database_subnets

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true


  ### nat gateway config
  enable_nat_gateway     = local.enable_nat_gateway
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  ### nat instance config
  create_nat_instance = false


  enable_vpc_endpoints = {
    s3       = true
    dynamodb = true
  }

  enable_flow_log = false

  ### a map of tags to add to all resources
  tags = local.tags


}
