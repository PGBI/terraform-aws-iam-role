# AWS IAM Role module

This module is a simple wrapper around the aws resources `aws_iam_role` and `aws_iam_role_policy`. It creates a role 
whose name will be prefixed with the terraform workspace and the project name and it attaches to it the specified inline
IAM policies.

Usage:

```hcl
module "project" {
  source  = "PGBI/project/aws"
  version = "~>0.1.0"

  name     = "myProject"
  vcs_repo = "github.com/account/project"
}

/**
 * Create an IAM role whose name will be "prod-myProject-ec2" if the terraform workspace is "prod".
 * Grant that role the permission to describe any EC2 instances.
 * Allow the EC2 Service and the IAM user john to assume that role.
 */
module "role" {
  source  = "PGBI/iam-role/aws"
  version = "~>0.1.0"

  description = "Role for EC2 instances."
  name        = "ec2"
  project     = module.project

  trusted_services = ["ec2.amazonaws.com"]
  trusted_iam_arns = ["arn:aws:iam::${module.project.account_id}:user/john"]
  
  policies = {
    describe_ec2s = {
      Action    = ["ec2:Describe*"]
      Resource  = "*"
      Effect    = "Allow"
    }
  }
}
```
