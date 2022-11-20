#-----------------------------------------------------
# versions.tf
# - terraform provider versions used within the module
#-----------------------------------------------------
terraform {
  required_version = ">= 1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.2.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
  shared_config_files = ["$HOME/.aws/config"]
}