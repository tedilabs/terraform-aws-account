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
