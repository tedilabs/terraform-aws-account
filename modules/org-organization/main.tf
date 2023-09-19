locals {
  metadata = {
    package = "terraform-aws-account"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}

locals {
  individual_trusted_accesses = toset([
    "ram.amazonaws.com",
  ])
  organization_managed_trusted_accesses = setsubtract(
    var.trusted_access_enabled_service_principals,
    local.individual_trusted_accesses
  )
}


###################################################
# Organization
###################################################

resource "aws_organizations_organization" "this" {
  feature_set = var.all_features_enabled ? "ALL" : "CONSOLIDATED_BILLING"
  enabled_policy_types = compact([
    var.ai_services_opt_out_policy_type_enabled ? "AISERVICES_OPT_OUT_POLICY" : "",
    var.backup_policy_type_enabled ? "BACKUP_POLICY" : "",
    var.service_control_policy_type_enabled ? "SERVICE_CONTROL_POLICY" : "",
    var.tag_policy_type_enabled ? "TAG_POLICY" : "",
  ])

  aws_service_access_principals = var.all_features_enabled ? local.organization_managed_trusted_accesses : []
}


###################################################
# AWS Managed Policies
###################################################

resource "aws_organizations_policy_attachment" "this" {
  for_each = toset(var.policies)

  target_id = aws_organizations_organization.this.roots[0].id
  policy_id = each.key
}


###################################################
# Individual Trusted Accesses
###################################################

resource "aws_ram_sharing_with_organization" "this" {
  count = contains(var.trusted_access_enabled_service_principals, "ram.amazonaws.com") ? 1 : 0
}
