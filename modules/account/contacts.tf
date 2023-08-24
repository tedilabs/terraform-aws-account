###################################################
# Primary Contact
###################################################

resource "aws_account_primary_contact" "this" {
  count = var.primary_contact != null ? 1 : 0

  full_name    = var.primary_contact.name
  company_name = var.primary_contact.company_name

  country_code       = var.primary_contact.country_code
  state_or_region    = var.primary_contact.state
  city               = var.primary_contact.city
  district_or_county = var.primary_contact.district
  address_line_1     = var.primary_contact.address_line_1
  address_line_2     = var.primary_contact.address_line_2
  address_line_3     = var.primary_contact.address_line_3
  postal_code        = var.primary_contact.postal_code

  phone_number = var.primary_contact.phone
  website_url  = var.primary_contact.website_url
}


###################################################
# Alternate Contacts
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
