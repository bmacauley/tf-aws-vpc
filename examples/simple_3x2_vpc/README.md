Simple 3x2 VPC
============

Configuration in this directory creates a simple VPC with  3 public subnets and 3 private subnets

There is a public and private subnet created per availability zone in addition to single NAT Gateway shared between all 3 availability zones

Usage
=====
Before you run this example, the user should be logged into AWS with an IAM role that has enough permissions to create the resources. The preferred method is to the Okta assume role login too(secret access key/access key id approaches are discouraged for security reasons)

To run this example you need to execute:

```bash
$ make init
$ make plan
$ make apply

To clean up...
$ make destroy
$ make clean
```

Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run `terraform destroy` when you don't need these resources.
