# AWS IAM Role module

This module is a simple wrapper around the aws resources `aws_iam_role` and `aws_iam_role_policy`. It creates a role 
whose name will be prefixed with the terraform workspace and the project name and attach to it the specified inline IAM
policies.

Usage:

```hcl
module "project" {
  source  = "PGBI/project/aws"
  version = "~>0.1.0"

  name     = "myProject"
  vcs_repo = "github.com/account/project"
}

/**
 * Creates an IAM role whose name will be "prod-myProject-ec2" if the terraform workspace is "prod".
 * Allow the EC2 Service to assume that role.
 * Attach to that Role an IAM policy allowing to describe any ec2 instances.
 */
module "role" {
  source  = "PGBI/iam-role/aws"
  version = "~>0.1.0"

  description = "Role for EC2 instances."
  name        = "ec2"
  project     = module.project

  assume_role_policy = {
    Action = "sts:AssumeRole",
    Principal = {
      Service = "ec2.amazonaws.com"
    }
    Effect = "Allow"
  }
  
  policies = {
    describe_ec2s = {
      Action    = ["ec2:Describe*"]
      Resource  = "*"
      Effect    = "Allow"
    }
  }
}
```
