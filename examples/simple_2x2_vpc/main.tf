provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "../../"

  name = "2x2-vpc"

  cidr = "172.31.0.0/24"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["172.31.0.0/26", "172.31.0.64/26"]
  public_subnets  = ["172.31.0.128/26", "172.31.0.192/26"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    "created_by"    =   "terraform"
    "project_id"    =   "p000xxx"
    "project_name"  =   "project xxx"
    "environment"   =   "sbx"
  }
  }
}
