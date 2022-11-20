create_vpc = true
name = "low-cost-example"
cidr             = "10.10.0.0/16"
public_subnets   = ["10.10.11.0/24", "10.10.12.0/24"]
private_subnets  = ["10.10.1.0/24", "10.10.2.0/24"]
database_subnets = ["10.10.21.0/24", "10.10.22.0/24"]

enable_nat_gateway   = false
create_nat_instance  = true
enable_dns_support   = true
enable_dns_hostnames = true