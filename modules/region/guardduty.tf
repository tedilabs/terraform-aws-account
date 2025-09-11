###################################################
# Delegated Administrator for GuardDuty
###################################################

resource "aws_guardduty_organization_admin_account" "this" {
  count = var.guardduty.delegated_administrator != null ? 1 : 0

  region = var.region

  admin_account_id = var.guardduty.delegated_administrator
}
