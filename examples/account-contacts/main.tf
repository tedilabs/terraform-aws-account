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

  primary_contact = {
    name           = "John Doe"
    company_name   = "Example Inc."
    country_code   = "US"
    state          = "California"
    city           = "Los Angeles"
    district       = "Downtown"
    address_line_1 = "123 Main St."
    address_line_2 = "Suite 456"
    address_line_3 = "Floor 7"
    postal_code    = "90012"
    phone          = "+1-555-555-5555"
    website_url    = "https://example.com"
  }

  billing_contact = {
    name  = "John Doe"
    title = "Billing Manager"
    email = "john.doe@example.com"
    phone = "+1-555-555-5555"
  }
  operation_contact = {
    name  = "Peter Smith"
    title = "Operation Manager"
    email = "peter.smith@example.com"
    phone = "+1-333-333-3333"
  }
  security_contact = {
    name  = "Bob Smith"
    title = "CISO"
    email = "bob.smith@example.com"
    phone = "+1-222-222-2222"
  }
}
