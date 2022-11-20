#-----------------------------------------
# locals.tf
# - module local variables
#-----------------------------------------
locals {
    name                = var.name
    nat_instance_type   = var.nat_instance_type
    ami                 = data.aws_ami.amazon_linux_arm64.id
    user_data           = file("${path.module}/user-data.sh")
    vpc_id              = var.aws_vpc_id
    subnet_id           = var.public_subnets_ids[0]


}