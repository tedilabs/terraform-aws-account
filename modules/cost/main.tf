locals {
  metadata = {
    package = "terraform-aws-account"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = data.aws_caller_identity.this.account_id
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}

data "aws_caller_identity" "this" {}


###################################################
# AWS Account Alias
###################################################

###################################################
# Cost Allocation Tags
###################################################

resource "aws_ce_cost_allocation_tag" "this" {
  for_each = toset(var.allocation_tags)

  tag_key = each.value
  status  = "Active"
}


###################################################
# Cost Anomaly Detection
###################################################

resource "aws_ce_anomaly_monitor" "this" {
  for_each = {
    for monitor in var.anomaly_detection_monitors :
    monitor.name => monitor
  }

  name = each.key

  monitor_type = each.value.type
  monitor_dimension = (each.value.type == "DIMENSIONAL"
    ? each.value.dimension
    : null
  )
  monitor_specification = (each.value.type == "CUSTOM"
    ? each.value.specification
    : null
  )

  tags = merge(
    {
      "Name" = each.key
    },
    local.module_tags,
    var.tags,
  )
}
