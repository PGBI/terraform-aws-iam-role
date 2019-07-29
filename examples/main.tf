/**
 * Configure the AWS Provider
 */
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

/**
 * Initialize the project
 */
module "project" {
  source  = "PGBI/project/aws"
  version = "~>0.1.0"

  name     = "myproject"
  vcs_repo = "github.com/account/project"
}

/**
 * Create an IAM role whose name will be "prod-myproject-ec2" if the terraform workspace is "prod".
 * Grant that role the permission to describe any EC2 instances.
 * Allow the EC2 Service and the IAM user john to assume that role.
 */
module "role" {
  source  = "PGBI/iam-role/aws"
  version = "~>0.2.0"

  description = "Role for EC2 instances."
  name        = "ec2"
  project     = module.project

  trusted_services = ["ec2.amazonaws.com"]

  policies = {
    describe_ec2s = {
      Action   = ["ec2:Describe*"]
      Resource = ["*"]
      Effect   = "Allow"
    }
  }
}
