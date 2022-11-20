#-----------------------------------------
# data.tf
#-----------------------------------------
# Get VPC data.
data "aws_vpc" "current_vpc" {
    id = var.aws_vpc_id
}

# Choosing the image for NAT Instance.


/*
aws ec2 describe-images \
    --owners 137112412989 \
    --filters "Name=name,Values=amzn2-ami-hvm-*-arm64-gp2" \
    "Name=architecture,Values=arm64" \
    "Name=virtualization-type,Values=hvm" | \
    jq .
*/
data "aws_ami" "amazon_linux_arm64" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-arm64-gp2"]
  }

  filter {
    name = "architecture"
    values = ["arm64"]
  }

  owners = ["137112412989"]
}


/*
aws ec2 describe-images \
    --owners 137112412989 \
    --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" \
    "Name=architecture,Values=x86_64" \
    "Name=virtualization-type,Values=hvm" | \
    jq .
*/
data "aws_ami" "amazon_linux_amd64" {
  most_recent = true
    filter {
      name   = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    filter {
      name = "architecture"
      values = ["x86_64"]
    }
    filter {
      name   = "virtualization-type"
      values = ["hvm"]
    }
    owners = ["137112412989"]
}




/*
aws ec2 describe-images \
    --owners 099720109477 \
    --filters "Name=name,Values=*ubuntu-focal-20.04-amd64-server-*" \
    "Name=architecture,Values=x86_64" \
    "Name=virtualization-type,Values=hvm" | \
    jq .
*/
data "aws_ami" "ubuntu_amd64" {
    most_recent = true
    filter {
        name   = "name"
        values = ["*ubuntu-focal-20.04-amd64-server-*"]
    }
    filter {
      name = "architecture"
      values = ["x86_64"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"]
}


/*
aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=*ubuntu-focal-20.04-arm64-server-*" \
  "Name=architecture,Values=arm64" \
  "Name=virtualization-type,Values=hvm" | \
  jq .
*/
data "aws_ami" "ubuntu_arm64" {
    most_recent = true
    filter {
        name   = "name"
        values = ["*ubuntu-focal-20.04-arm64-server-*"]
    }
    filter {
      name = "architecture"
      values = ["arm64"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"]
}



// Get NAT Instance data.
data "aws_instance" "nat_instance_data" {
  instance_id = aws_instance.nat_instance.id
}

// Get route tables of private networks of current environment.
data "aws_route_tables" "private" {
  vpc_id   = var.aws_vpc_id

    filter {
    name   = "tag:Name"
    values = ["${local.name}-private*"]
  }
}