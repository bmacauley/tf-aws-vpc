#!/bin/bash

# set password for ec2 serial port - debugging
echo "ubuntu:password" | chpasswd

apt install iputils-ping

snap start amazon-ssm-agent