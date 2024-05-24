###################################################
# CloudWatch OAM (Observability Access Manager)
###################################################

module "cloudwatch_oam_sink" {
  count = var.cloudwatch.oam_sink != null ? 1 : 0

  source  = "tedilabs/observability/aws//modules/cloudwatch-oam-sink"
  version = "~> 0.2.0"

  name            = var.cloudwatch.oam_sink.name
  telemetry_types = var.cloudwatch.oam_sink.telemetry_types

  allowed_source_accounts           = var.cloudwatch.oam_sink.allowed_source_accounts
  allowed_source_organizations      = var.cloudwatch.oam_sink.allowed_source_organizations
  allowed_source_organization_paths = var.cloudwatch.oam_sink.allowed_source_organization_paths

  resource_group_enabled = false
  module_tags_enabled    = false

  tags = merge(
    local.module_tags,
    var.tags,
    var.cloudwatch.oam_sink.tags,
  )
}
