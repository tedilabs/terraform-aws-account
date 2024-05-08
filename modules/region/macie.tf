###################################################
# Delegated Administrator for Macie
###################################################

resource "aws_macie2_organization_admin_account" "this" {
  count = var.macie.delegated_administrator != null ? 1 : 0

  admin_account_id = var.macie.delegated_administrator
}
