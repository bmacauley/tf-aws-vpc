# AWS VPC Terraform module
Terraform module which creates VPC resources on AWS.

## Features
These types of resources are supported:

* [VPC](https://www.terraform.io/docs/providers/aws/r/vpc.html)
* [Subnet](https://www.terraform.io/docs/providers/aws/r/subnet.html)
* [Route](https://www.terraform.io/docs/providers/aws/r/route.html)
* [Route table](https://www.terraform.io/docs/providers/aws/r/route_table.html)
* [Internet Gateway](https://www.terraform.io/docs/providers/aws/r/internet_gateway.html)
* [NAT Gateway](https://www.terraform.io/docs/providers/aws/r/nat_gateway.html)
* [VPN Gateway](https://www.terraform.io/docs/providers/aws/r/vpn_gateway.html)
* [VPC Endpoint](https://www.terraform.io/docs/providers/aws/r/vpc_endpoint.html) (S3 and DynamoDB)
* [RDS DB Subnet Group](https://www.terraform.io/docs/providers/aws/r/db_subnet_group.html)
* [ElastiCache Subnet Group](https://www.terraform.io/docs/providers/aws/r/elasticache_subnet_group.html)
* [DHCP Options Set](https://www.terraform.io/docs/providers/aws/r/vpc_dhcp_options.html)


## Dependencies
Terraform version 0.10.3 or newer is required for this module to work.

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| azs | A list of availability zones in the region | list | `<list>` | no |
| cidr | The CIDR block for the VPC | string | `` | no |
| create_database_subnet_group | Controls if database subnet group should be created | string | `true` | no |
| database_subnet_tags | Additional tags for the database subnets | map | `<map>` | no |
| database_subnets | A list of database subnets | list | `<list>` | no |
| dhcp_options_domain_name | Specifies DNS name for DHCP options set | string | `` | no |
| dhcp_options_domain_name_servers | Specify a list of DNS server addresses for DHCP options set, default to AWS provided | list | `<list>` | no |
| dhcp_options_netbios_name_servers | Specify a list of netbios servers for DHCP options set | list | `<list>` | no |
| dhcp_options_netbios_node_type | Specify netbios node_type for DHCP options set | string | `` | no |
| dhcp_options_ntp_servers | Specify a list of NTP servers for DHCP options set | list | `<list>` | no |
| dhcp_options_tags | Additional tags for the DHCP option set | map | `<map>` | no |
| elasticache_subnet_tags | Additional tags for the elasticache subnets | map | `<map>` | no |
| elasticache_subnets | A list of elasticache subnets | list | `<list>` | no |
| enable_dhcp_options | Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type | string | `false` | no |
| enable_dns_hostnames | Should be true to enable DNS hostnames in the VPC | string | `false` | no |
| enable_dns_support | Should be true to enable DNS support in the VPC | string | `true` | no |
| enable_dynamodb_endpoint | Should be true if you want to provision a DynamoDB endpoint to the VPC | string | `false` | no |
| enable_nat_gateway | Should be true if you want to provision NAT Gateways for each of your private networks | string | `false` | no |
| enable_s3_endpoint | Should be true if you want to provision an S3 endpoint to the VPC | string | `false` | no |
| enable_vpn_gateway | Should be true if you want to create a new VPN Gateway resource and attach it to the VPC | string | `false` | no |
| external_nat_ip_ids | List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips) | list | `<list>` | no |
| instance_tenancy | A tenancy option for instances launched into the VPC | string | `default` | no |
| map_public_ip_on_launch | Should be false if you do not want to auto-assign public IP on launch | string | `true` | no |
| name | Name to be used on all the resources as identifier | string | `` | no |
| private_propagating_vgws | A list of VGWs the private route table should propagate | list | `<list>` | no |
| private_route_table_tags | Additional tags for the private route tables | map | `<map>` | no |
| private_subnet_tags | Additional tags for the private subnets | map | `<map>` | no |
| private_subnets | A list of private subnets inside the VPC | list | `<list>` | no |
| public_propagating_vgws | A list of VGWs the public route table should propagate | list | `<list>` | no |
| public_route_table_tags | Additional tags for the public route tables | map | `<map>` | no |
| public_subnet_tags | Additional tags for the public subnets | map | `<map>` | no |
| public_subnets | A list of public subnets inside the VPC | list | `<list>` | no |
| reuse_nat_ips | Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable | string | `false` | no |
| single_nat_gateway | Should be true if you want to provision a single shared NAT Gateway across all of your private networks | string | `false` | no |
| tags | A map of tags to add to all resources | map | `<map>` | no |
| vpc_tags | Additional tags for the VPC | map | `<map>` | no |

## Outputs
| Name | Description |
|------|-------------|
| database_subnet_group | ID of database subnet group |
| database_subnets | List of IDs of database subnets |
| database_subnets_cidr_blocks | List of cidr_blocks of database subnets |
| default_network_acl_id | The ID of the default network ACL |
| default_route_table_id | The ID of the default route table |
| default_security_group_id | The ID of the security group created by default on VPC creation |
| elasticache_subnet_group | ID of elasticache subnet group |
| elasticache_subnets | List of IDs of elasticache subnets |
| elasticache_subnets_cidr_blocks | List of cidr_blocks of elasticache subnets |
| igw_id | Internet Gateway |
| nat_ids | List of allocation ID of Elastic IPs created for AWS NAT Gateway |
| nat_public_ips | List of public Elastic IPs created for AWS NAT Gateway |
| natgw_ids | List of NAT Gateway IDs |
| private_route_table_ids | List of IDs of private route tables |
| private_subnets | Subnets |
| private_subnets_cidr_blocks | List of cidr_blocks of private subnets |
| public_route_table_ids | Route tables |
| public_subnets | List of IDs of public subnets |
| public_subnets_cidr_blocks | List of cidr_blocks of public subnets |
| vgw_id | VPN Gateway |
| vpc_cidr_block | The CIDR block of the VPC |
| vpc_endpoint_dynamodb_id | The ID of VPC endpoint for DynamoDB |
| vpc_endpoint_s3_id | VPC Endpoints |
| vpc_id | VPC |

## Usage


```hcl
provider "aws" {
  version = "~> 1.0.0"
  region  = "eu-west-1"
}

module "vpc" {
  source = "github/bmacauley/tf-aws-vpc"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    "created_by"    =   "terraform"
    "project_id"    =   "p000xxx"
    "project_name"  =   "project xxx"
  }
}
```

## External NAT Gateway IPs
By default this module will provision new Elastic IPs for the VPC's NAT Gateways.
This means that when creating a new VPC, new IPs are allocated, and when that VPC is destroyed those IPs are released.
Sometimes it is handy to keep the same IPs even after the VPC is destroyed and re-created.
To that end, it is possible to assign existing IPs to the NAT Gateways.
This prevents the destruction of the VPC from releasing those IPs, while making it possible that a re-created VPC uses the same IPs.

To achieve this, allocate the IPs outside the VPC module declaration.
```hcl
resource "aws_eip" "nat" {
  count = 3

  vpc = true
}
```

Then, pass the allocated IPs as a parameter to this module.
```hcl
module "vpc" {
  source = "github/bmacauley/tf-aws-vpc"

  # The rest of arguments are omitted for brevity

  enable_nat_gateway  = true
  single_nat_gateway  = false
  external_nat_ip_ids = ["${aws_eip.nat.*.id}"]   # <= IPs specified here as input to the module
}
```

Note that in the example we allocate 3 IPs because we will be provisioning 3 NAT Gateways (due to `single_nat_gateway = false` and having 3 subnets).
If, on the other hand, `single_nat_gateway = true`, then `aws_eip.nat` would only need to allocate 1 IP.
Passing the IPs into the module is done by setting variable `external_nat_ip_ids = ["${aws_eip.nat.*.id}"]`.


## Examples
* [Simple 2x2 VPC](https://github.com/bmacauley/tf_aws_vpc/tree/master/examples/simple_2x2_vpc)
* [Simple 3x2 VPC](https://github.com/bmacauley/tf_aws_vpc/tree/master/examples/simple_3x2_vpc)
* [Complete VPC](https://github.com/bmacauley/tf_aws_vpc/tree/master/examples/complete_vpc)

A few edge case examples...
* [Asymmetrical VPC](https://github.com/bmacauley/tf_aws_vpc/tree/master/examples/asymmetrical_vpc)
* [VPC with no private subnets](https://github.com/bmacauley/tf_aws_vpc/tree/master/examples/no_private_subnets_vpc)


## Authors
* [Brian Macauley](https://github.com/bmacauley) &lt;brian.macauley@gmail.com&gt;

Based on `terraform-community-modules/tf_aws_vpc` and `terraform-aws-modules/terraform-aws-vpc`  
[Module contributors](https://github.com/terraform-community-modules/tf_aws_vpc/graphs/contributors).
Managed by [Anton Babenko](https://github.com/antonbabenko).

## License
[MIT](/LICENSE)
