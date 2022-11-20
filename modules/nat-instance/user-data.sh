#!/bin/bash

# ste password for ec2 serial port
echo "password" | passwd --stdin ec2-user


# Configure networking to enable it as a NAT Instance
sudo sysctl -w net.ipv4.ip_forward=1
if [[ ! -z $(grep "net.ipv4.ip_forward = 1" "/etc/sysctl.conf") ]]; then echo "IP forward config found"; else echo "net.ipv4.ip_forward = 1" | sudo tee --append /etc/sysctl.conf; fi
sudo /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo yum install iptables-services
sudo service iptables save



# Disabling services
sudo service sshd stop
systemctl disable sshd
sudo systemctl stop rpcbind
systemctl disable rpcbind

# Update instance
sudo yum -y update
