data "aws_regions" "this" {
  # Always true
  all_regions = aws_account_region.this != null

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required", "opted-in"]
  }
}

locals {
  all_available_regions = data.aws_regions.this.names
}


###################################################
# Regions
###################################################

# INFO: Not supported attributes
# - `account_id`
# INFO: Not supported idempotent operation
# TODO: How to manage disabled region?
resource "aws_account_region" "this" {
  for_each = var.additional_regions

  region_name = each.key
  enabled     = each.value
}
