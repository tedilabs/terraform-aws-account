locals {
  independent_services = [
    "fms.amazonaws.com",
    "macie.amazonaws.com",
  ]
}


###################################################
# Delegated Administrators for Organization Account
###################################################

resource "aws_organizations_delegated_administrator" "this" {
  for_each = toset([
    for service in var.delegated_services :
    service
    if !contains(local.independent_services, service)
  ])

  account_id        = aws_organizations_account.this.id
  service_principal = each.key
}

resource "aws_macie2_organization_admin_account" "this" {
  count = contains(var.delegated_services, "macie.amazonaws.com") ? 1 : 0

  admin_account_id = aws_organizations_account.this.id
}

resource "aws_fms_admin_account" "this" {
  count = contains(var.delegated_services, "fms.amazonaws.com") ? 1 : 0

  account_id = aws_organizations_account.this.id
}
