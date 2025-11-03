locals {
  savings_estimation_mode = {
    AFTER_DISCOUNTS  = "AfterDiscounts"
    BEFORE_DISCOUNTS = "BeforeDiscounts"
  }
}


###################################################
# Configurations for Cost Optimization Hub
###################################################

resource "aws_costoptimizationhub_enrollment_status" "this" {
  count = var.cost_optimization_hub.enabled ? 1 : 0

  include_member_accounts = var.cost_optimization_hub.scope == "ORGANIZATION"

  lifecycle {
    ignore_changes = [
      include_member_accounts,
    ]
  }
}

resource "aws_costoptimizationhub_preferences" "this" {
  count = length(aws_costoptimizationhub_enrollment_status.this) > 0 ? 1 : 0

  member_account_discount_visibility = (var.cost_optimization_hub.scope == "ORGANIZATION"
    ? (var.cost_optimization_hub.allow_member_account_discount_visibility ? "All" : "None")
    : null
  )
  savings_estimation_mode = local.savings_estimation_mode[var.cost_optimization_hub.savings_estimation_mode]
}
