locals {
  available_regions = [
    "af-south-1",
    "ap-east-1",
    "ap-east-2",
    "ap-south-2",
    "ap-southeast-3",
    "ap-southeast-4",
    "ap-southeast-5",
    "ap-southeast-6",
    "ap-southeast-7",
    "ca-west-1",
    "eu-south-1",
    "eu-south-2",
    "eu-central-2",
    "me-south-1",
    "me-central-1",
    "mx-central-1",
    "il-central-1",
  ]
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
