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

  password_policy = {
    minimum_password_length      = 8
    require_numbers              = true
    require_symbols              = true
    require_lowercase_characters = true
    require_uppercase_characters = false

    allow_users_to_change_password = true
    hard_expiry                    = false
    max_password_age               = 90
    password_reuse_prevention      = 0
  }
}
