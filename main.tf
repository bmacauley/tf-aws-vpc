#------------------------------------------
# main.tf
# Module: tf-aws-vpc
#------------------------------------------

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  version = "3.18.1"

  create_vpc = local.create_vpc

  name = local.name
  cidr = local.cidr
  azs  = local.azs

  ### public subnets
  public_subnets          = local.public_subnets
  map_public_ip_on_launch = local.map_public_ip_on_launch

  ### private subnets
  private_subnets = local.private_subnets

  ### database subnets
  database_subnets                       = local.database_subnets
  create_database_subnet_group           = local.create_database_subnet_group
  create_database_subnet_route_table     = local.create_database_subnet_route_table
  create_database_internet_gateway_route = local.create_database_internet_gateway_route

  ### enable dhcp options
  enable_dhcp_options      = var.enable_dhcp_options
  dhcp_options_domain_name = var.dhcp_options_domain_name

  ### dns
  enable_dns_hostnames = local.enable_dns_hostnames
  enable_dns_support   = local.enable_dns_support

  ### nat gateway config
  enable_nat_gateway     = local.enable_nat_gateway
  single_nat_gateway     = local.single_nat_gateway
  one_nat_gateway_per_az = local.one_nat_gateway_per_az



  ## manage default security group
  manage_default_security_group = true
  default_security_group_tags   = { Name = "${local.name}-default" }

  ### enable flowlogs
  enable_flow_log           = local.enable_flow_log
  flow_log_destination_type = local.flow_log_destination_type
  flow_log_destination_arn  = module.s3_vpc_flow_log.s3_bucket_arn

  ### a map of tags to add to all resources
  tags = local.tags

  public_subnet_tags = {
    subnet_type              = "public"
    "kubernetes.io/role/elb" = "1"
  }

  public_route_table_tags = { Name = "${local.name}-public" }


  private_subnet_tags = {
    subnet_type                       = "private"
    "kubernetes.io/role/internal-elb" = "1"
  }

  private_route_table_tags = { Name = "${local.name}-private" }

  database_subnet_tags = {
    subnet_type = "database"
  }

  database_route_table_tags = { Name = "${local.name}-database" }
}

module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.14.2"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [data.aws_security_group.default.id]

  endpoints = {
    # gateway endpoints - free
    # https://docs.aws.amazon.com/vpc/latest/privatelink/gateway-endpoints.html
    s3 = {
      create          = local.enable_vpc_endpoints["s3"]
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.intra_route_table_ids, module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
      tags            = { Name = "s3-vpc-endpoint" }
    },
    dynamodb = {
      create          = local.enable_vpc_endpoints["dynamodb"]
      service         = "dynamodb"
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.intra_route_table_ids, module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
      # policy          = data.aws_iam_policy_document.dynamodb_endpoint_policy.json
      tags = { Name = "dynamodb-vpc-endpoint" }
    },

    # interface endpoints - cost money
    # https://docs.aws.amazon.com/vpc/latest/privatelink/aws-services-privatelink-support.html

    #   athena = {
    #     create              = local.enable_vpc_endpoints["athena"]
    #     service             = "athena"
    #     private_dns_enabled = true
    #     subnet_ids          = module.vpc.private_subnets
    #     tags                = { Name = "athena-vpc-endpoint" }
    #   },
    #   ecs = {
    #     create              = local.enable_vpc_endpoints["ecs"]
    #     service             = "ecs"
    #     private_dns_enabled = true
    #     subnet_ids          = module.vpc.private_subnets
    #     tags                = { Name = "ecs-vpc-endpoint" }
    #   },
    #   ecs_telemetry = {
    #     create              = local.enable_vpc_endpoints["ecs_telemetry"]
    #     service             = "ecs-telemetry"
    #     private_dns_enabled = true
    #     subnet_ids          = module.vpc.private_subnets
    #     tags                = { Name = "ecs-telemetry-vpc-endpoint" }
    #   },
    #   ec2 = {
    #     create              = local.enable_vpc_endpoints["ec2"]
    #     service             = "ec2"
    #     private_dns_enabled = true
    #     subnet_ids          = module.vpc.private_subnets
    #     security_group_ids  = [aws_security_group.vpc_tls.id]
    #     tags                = { Name = "ec2-vpc-endpoint" }
    #   },
    #   ecr_api = {
    #     create              = local.enable_vpc_endpoints["ecr_api"]
    #     service             = "ecr.api"
    #     private_dns_enabled = true
    #     subnet_ids          = module.vpc.private_subnets
    #     policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    #     tags                = { Name = "ecr-api-endpoint" }
    #   },
    #   ecr_dkr = {
    #     create              = local.enable_vpc_endpoints["ecr_dkr"]
    #     service             = "ecr.dkr"
    #     private_dns_enabled = true
    #     subnet_ids          = module.vpc.private_subnets
    #     policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    #     tags                = { Name = "ecr-dkr-endpoint" }
    #   },
    #   ec2messages = {
    #     create              = local.enable_vpc_endpoints["ec2messages"]
    #     service             = "ec2messages"
    #     private_dns_enabled = true
    #     subnet_ids          = module.vpc.private_subnets
    #     tags                = { Name = "ec2messages-endpoint" }
    #   },
    #   glue = {
    #     create              = local.enable_vpc_endpoints["glue"]
    #     service             = "glue"
    #     private_dns_enabled = true
    #     subnet_ids          = module.vpc.private_subnets
    #     security_group_ids  = [aws_security_group.vpc_tls.id]
    #     tags                = { Name = "glue-endpoint" }
    #   },
    #   kms = {
    #     create              = local.enable_vpc_endpoints["kms"]
    #     service             = "kms"
    #     private_dns_enabled = true
    #     subnet_ids          = module.vpc.private_subnets
    #     security_group_ids  = [aws_security_group.vpc_tls.id]
    #     tags                = { Name = "kms-endpoint" }
    #   },
    #   lambda = {
    #     create              = local.enable_vpc_endpoints["lambda"]
    #     service             = "lambda"
    #     private_dns_enabled = true
    #     subnet_ids          = module.vpc.private_subnets
    #     tags                = { Name = "lambda-vpc-endpoint" }
    #   },
    #   ssm = {
    #     create              = local.enable_vpc_endpoints["ssm"]
    #     service             = "ssm"
    #     private_dns_enabled = true
    #     subnet_ids          = module.vpc.private_subnets
    #     security_group_ids  = [aws_security_group.vpc_tls.id]
    #     tags                = { Name = "ssm-vpc-endpoint" }
    #   },
    #   ssmmessages = {
    #     create              = local.enable_vpc_endpoints["ssmmessages"]
    #     service             = "ssmmessages"
    #     private_dns_enabled = true
    #     subnet_ids          = module.vpc.private_subnets
    #     tags                = { Name = "ssmmessages-vpc-endpoint" }
    #   },


  }

  tags = merge(local.common_tags, {
    vpc_endpoint = "true"
    core_infra   = "true"
  })
}


# get default security group on vpc
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}



# # VPC Flow Log S3 Bucket
module "s3_vpc_flow_log" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "3.6.0"
  create_bucket = local.enable_flow_log
  bucket        = local.vpc_flow_log_bucket_name
  policy        = data.aws_iam_policy_document.flow_log_s3.json

  lifecycle_rule = [
    {
      id      = "log"
      enabled = true
      expiration = {
        days = 30
      }
    }
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "vpc-flow-logs-s3-bucket"
    }
  )

  force_destroy = false

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  # S3 Bucket Ownership Controls
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"
}

data "aws_iam_policy_document" "flow_log_s3" {
  statement {
    sid       = "AWSLogDeliveryWrite"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${local.vpc_flow_log_bucket_name}/AWSLogs/*"]
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
  }

  statement {
    sid       = "AWSLogDeliveryAclCheck"
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::${local.vpc_flow_log_bucket_name}"]
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
  }
}




module "nat_instance" {
  source = "./modules/nat-instance"
  count  = (local.create_nat_instance ? 1 : 0)
  # number_of_azs         = var.number_of_azs
  name               = local.name
  aws_vpc_id         = module.vpc.vpc_id
  nat_instance_type  = local.nat_instance_type
  public_subnets_ids = module.vpc.public_subnets
  depends_on = [
    module.vpc
  ]
}
