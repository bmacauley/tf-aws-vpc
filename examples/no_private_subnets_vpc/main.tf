# There are no private subnets in this VPC setup.
#
# Github issue: https://github.com/terraform-aws-modules/terraform-aws-vpc/issues/46
provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "../../"

  name = "no-private-subnets"

  cidr = "172.31.0.0/16"

  azs                 = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnets      = ["172.31.0.0/22", "172.31.4.0/22", "172.31.8.0/22"]
  private_subnets     = []
  database_subnets    = ["172.31.128.0/24", "172.31.129.0/24"]
  elasticache_subnets = ["172.31.131.0/24", "172.31.132.0/24", "172.31.133.0/24"]

  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_nat_gateway   = false

  tags = {
    project_id      = "p000xxx",
    project_name = "project xxx"
    environment =  "sbx"
  }
}
