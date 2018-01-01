provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "../../"

  name = "complete-example"

  cidr = "172.31.0.0/16"

  azs                 = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets     = ["172.31.1.0/24", "172.31.2.0/24", "172.31.3.0/24"]
  public_subnets      = ["172.31.11.0/24", "172.31.12.0/24", "172.31.13.0/24"]
  database_subnets    = ["172.31.21.0/24", "172.31.22.0/24", "172.31.23.0/24"]
  elasticache_subnets = ["172.31.31.0/24", "172.31.32.0/24", "172.31.33.0/24"]

  create_database_subnet_group = false

  enable_nat_gateway = true
  enable_vpn_gateway = true

  enable_s3_endpoint       = true
  enable_dynamodb_endpoint = true

  enable_dhcp_options              = true
  dhcp_options_domain_name         = "service.consul"
  dhcp_options_domain_name_servers = ["127.0.0.1", "172.31.0.2"]

  tags = {
    "created_by"    =   "terraform"
    "project_id"    =   "p000xxx"
    "project_name"  =   "project xxx"
    "environment"   =   "sbx"
  }
}
