data "aws_caller_identity" "this" {}


###################################################
# AWS Account Alias
###################################################

resource "aws_iam_account_alias" "this" {
  account_alias = var.name
}


###################################################
# Password Policy for AWS Account and IAM Users
###################################################

resource "aws_iam_account_password_policy" "this" {
  minimum_password_length        = var.password_policy.minimum_password_length
  require_numbers                = var.password_policy.require_numbers
  require_symbols                = var.password_policy.require_symbols
  require_lowercase_characters   = var.password_policy.require_lowercase_characters
  require_uppercase_characters   = var.password_policy.require_uppercase_characters
  allow_users_to_change_password = var.password_policy.allow_users_to_change_password
  hard_expiry                    = var.password_policy.hard_expiry
  max_password_age               = var.password_policy.max_password_age
  password_reuse_prevention      = var.password_policy.password_reuse_prevention
}


###################################################
# Account Contacts
###################################################

resource "aws_account_alternate_contact" "billing" {
  count = var.billing_contact != null ? 1 : 0

  alternate_contact_type = "BILLING"

  name          = var.billing_contact.name
  title         = try(var.billing_contact.title, "Billing Manager")
  email_address = var.billing_contact.email
  phone_number  = var.billing_contact.phone
}

resource "aws_account_alternate_contact" "operation" {
  count = var.operation_contact != null ? 1 : 0

  alternate_contact_type = "OPERATIONS"

  name          = var.operation_contact.name
  title         = try(var.operation_contact.title, "Operation Manager")
  email_address = var.operation_contact.email
  phone_number  = var.operation_contact.phone
}

resource "aws_account_alternate_contact" "security" {
  count = var.security_contact != null ? 1 : 0

  alternate_contact_type = "SECURITY"

  name          = var.security_contact.name
  title         = try(var.security_contact.title, "Security Manager")
  email_address = var.security_contact.email
  phone_number  = var.security_contact.phone
}
