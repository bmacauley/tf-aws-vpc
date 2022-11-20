provider "aws" {
  region = "eu-west-1"
}


locals {
  create_vpc  = var.create_vpc
  name        = var.name
  azs = [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1],
    data.aws_availability_zones.available.names[2]
  ]
  cidr             = var.cidr
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  database_subnets = var.database_subnets

  enable_nat_gateway  = var.enable_nat_gateway
  create_nat_instance = var.create_nat_instance
  nat_instance_type   = var.nat_instance_type

  enable_dns_support    = var.enable_dns_support
  enable_dns_hostnames  = var.enable_dns_hostnames

  tags = {
    managed_by = "terraform"
  }
}

module "vpc" {
  source = "../../"

  create_vpc = true

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
  create_nat_instance   = local.create_nat_instance
  nat_instance_type     = local.nat_instance_type


  enable_vpc_endpoints = {
    s3       = true
    dynamodb = true
  }

  enable_flow_log = false

  ### a map of tags to add to all resources
  tags = local.tags


}


# Test instance

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "test-instance"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t4g.nano"
  vpc_security_group_ids = [aws_security_group.ec2_test_instance.id]
  subnet_id              = element(module.vpc.private_subnets, 0)

  iam_instance_profile   = aws_iam_instance_profile.ec2_test_instance.name

  user_data              = file("${path.module}/user-data.sh")

  tags = {
    managed_by   = "terraform"
  }

  depends_on = [
    module.vpc
  ]
}


resource "aws_iam_instance_profile" "ec2_test_instance" {
  name = "ec2-test-instance-profile"
  role = aws_iam_role.ec2_test_instance.name
}

resource "aws_iam_role" "ec2_test_instance" {
  name = "ec2-test-instance-ssm-agent-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": {"Service": "ec2.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }
  })
}

resource "aws_iam_role_policy_attachment" "ec2_test_instance" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ec2_test_instance.name
}


resource "aws_security_group" "ec2_test_instance" {
    vpc_id      = module.vpc.vpc_id
    name        = "ec2-test-instance-sg"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "all"
        cidr_blocks     = ["0.0.0.0/0"]
        prefix_list_ids = []
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "all"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    tags = {
        Name = "ec2-test-instance-sg"
    }
}
