provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "../../"

  name = "simple-vpc-3x2"

  cidr = "172.31.0.0/24"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["172.31.0.0/27", "172.31.0.32/27", "172.31.0.64/27"]
  public_subnets  = ["172.31.0.96/27", "172.31.0.160/27", "172.31.0.192/27"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    "created_by"    =   "terraform"
    "project_id"    =   "p000xxx"
    "project_name"  =   "project xxx"
    "environment"   =   "sbx"
  }
}
