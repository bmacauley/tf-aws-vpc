



# Get AWS AZ zones
data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name   = "name"
        values = ["*ubuntu-focal-20.04-arm64-server-*"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"]
}