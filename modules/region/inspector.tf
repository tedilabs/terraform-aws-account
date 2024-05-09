###################################################
# Delegated Administrator for Inspector
###################################################

resource "aws_inspector2_delegated_admin_account" "this" {
  count = var.inspector.delegated_administrator != null ? 1 : 0

  account_id = var.inspector.delegated_administrator
}
