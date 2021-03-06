Complete VPC example
====================

Configuration in this directory creates set of VPC resources which may be sufficient for staging or production environment (look into [simple-vpc-2x2](../simple-vpc-2x2) for more simplified setup).

There are public, private, database, ElastiCache subnets, NAT Gateways created in each availability zone.

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

Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run `make destroy` when you don't need these resources.



