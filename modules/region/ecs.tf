locals {
  ecs_container_insights_mode = {
    "ENABLED"  = "enabled"
    "ENHANCED" = "enhanced"
    "DISABLED" = "disabled"
  }
}


###################################################
# Default Settings for ECS
###################################################

# INFO: Deprecated settings
# - `containerInstanceLongArnFormat` - Always `enabled` since 2021-04-01
# - `serviceLongArnFormat` - Always `enabled` since 2021-04-01
# - `taskLongArnFormat` - Always `enabled` since 2021-04-01
# - `tagResourceAuthorization` - Always `enabled` since 2024-03-29
# INFO: Read-only settings
# - `guardDutyActivate`
resource "aws_ecs_account_setting_default" "container_insights_mode" {
  region = var.region

  name  = "containerInsights"
  value = local.ecs_container_insights_mode[var.ecs.container_insights.mode]
}

resource "aws_ecs_account_setting_default" "awsvpc_trunking" {
  region = var.region

  name  = "awsvpcTrunking"
  value = var.ecs.awsvpc_trunking_enabled ? "enabled" : "disabled"
}

resource "aws_ecs_account_setting_default" "dual_stack_ipv6" {
  region = var.region

  name  = "dualStackIPv6"
  value = var.ecs.dual_stack_ipv6_enabled ? "enabled" : "disabled"
}

resource "aws_ecs_account_setting_default" "default_log_driver_mode" {
  region = var.region

  name  = "defaultLogDriverMode"
  value = var.ecs.default_log_driver_mode
}


###################################################
# Default Settings for ECS Fargate
###################################################

resource "aws_ecs_account_setting_default" "fargate_event_windows" {
  region = var.region

  name  = "fargateEventWindows"
  value = var.ecs.fargate.event_windows ? "enabled" : "disabled"
}

# resource "aws_ecs_account_setting_default" "fargate_fips_mode" {
#   region = var.region
#
#   name  = "fargateFIPSMode"
#   value = var.ecs.fargate.fips_mode ? "enabled" : "disabled"
# }

resource "aws_ecs_account_setting_default" "fargate_task_retirement_wait_period" {
  region = var.region

  name  = "fargateTaskRetirementWaitPeriod"
  value = tostring(var.ecs.fargate.task_retirement_wait_period)
}
