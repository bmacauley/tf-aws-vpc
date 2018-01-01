# List of AZs and private subnets are not of equal length
#
# This example creates resources which are not present in all AZs.
# This should be seldomly needed from architectural point of view,
# and it can also lead this module to some edge cases.
#
# Github issue: https://github.com/terraform-aws-modules/terraform-aws-vpc/issues/44

provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "../../"

  name = "asymmetrical"

  cidr = "172.31.0.0/16"

  azs              = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets  = ["172.31.1.0/24"]
  public_subnets   = ["172.31.101.0/24", "172.31.102.0/24"]
  database_subnets = ["172.31.21.0/24", "172.31.22.0/24", "172.31.23.0/24"]

  create_database_subnet_group = true
  enable_nat_gateway           = true

  tags = {
    "created_by"    =   "terraform"
    "project_id"    =   "p000xxx"
    "project_name"  =   "project xxx"
    "environment"   =   "sbx"
  }
}
