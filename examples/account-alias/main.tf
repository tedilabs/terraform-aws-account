provider "aws" {
  region = "us-east-1"
}


###################################################
# AWS Account
###################################################

module "account" {
  source = "../../modules/account"
  # source  = "tedilabs/account/aws//modules/account"
  # version = "~> 0.26.0"

  # This is alias for the AWS account.
  name = "example-210925"
}
