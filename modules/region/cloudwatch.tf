###################################################
# CloudWatch OAM (Observability Access Manager)
###################################################

module "cloudwatch_oam_sink" {
  for_each = {
    for sink in var.cloudwatch.oam_sinks :
    sink.name => sink
  }

  source  = "tedilabs/observability/aws//modules/cloudwatch-oam-sink"
  version = "~> 0.2.0"

  name            = each.key
  telemetry_types = each.value.telemetry_types

  allowed_source_accounts           = each.value.allowed_source_accounts
  allowed_source_organizations      = each.value.allowed_source_organizations
  allowed_source_organization_paths = each.value.allowed_source_organization_paths

  resource_group_enabled = false
  module_tags_enabled    = false

  tags = merge(
    local.module_tags,
    var.tags,
    each.value.tags,
  )
}
