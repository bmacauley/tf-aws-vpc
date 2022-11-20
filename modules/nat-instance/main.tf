#-----------------------------------------
# main.tf
#-----------------------------------------


resource "aws_instance" "nat_instance" {
  # Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs.
  instance_type               = local.nat_instance_type
  ami                         = local.ami
  iam_instance_profile        = aws_iam_instance_profile.nat_instance.name
  subnet_id                   = local.subnet_id
  vpc_security_group_ids      = [aws_security_group.nat_instance.id]
  source_dest_check           = false
  associate_public_ip_address = true

  user_data = local.user_data
  tags = {
    Name = "${local.name}-nat-instance"
  }

}

## Create instance profile.
resource "aws_iam_instance_profile" "nat_instance" {
  name = "${local.name}-nat-instance-profile"
  role = aws_iam_role.ssm_agent_role.name
}

## Create role.
resource "aws_iam_role" "ssm_agent_role" {
  name = "${local.name}-nat-instance-ssm-agent-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : {
      "Effect" : "Allow",
      "Principal" : { "Service" : "ec2.amazonaws.com" },
      "Action" : "sts:AssumeRole"
    }
  })
}

## Attach role to policy.
resource "aws_iam_role_policy_attachment" "nat_instance" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ssm_agent_role.name
}



## Create security groups that allows all traffic from VPC's cidr to NAT-Instance.
resource "aws_security_group" "nat_instance" {
  vpc_id = local.vpc_id
  name   = "${local.name}-nat-instance-sg"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = [data.aws_vpc.current_vpc.cidr_block]
    # cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${local.name}-nat-instance-sg"
  }
}

## Route private networks through NAT-Instance network interface.
resource "aws_route" "nat_instance" {
  count                  = 1
  route_table_id         = element(tolist(data.aws_route_tables.private.ids[*]), count.index)
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_instance.nat_instance.primary_network_interface_id
}
