###################################################
# Delegated Administrator for Inspector
###################################################

# TODO: Move to other module
resource "aws_inspector2_delegated_admin_account" "this" {
  count = var.inspector.delegated_administrator != null ? 1 : 0

  region = var.region

  account_id = var.inspector.delegated_administrator
}
