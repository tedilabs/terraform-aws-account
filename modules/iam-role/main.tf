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


###################################################
# IAM Role
###################################################

# INFO: Not supported attributes
# - `name_prefix`
# INFO: Deprecated attributes
# - `inline_policy`
# - `managed_policy_arns`
resource "aws_iam_role" "this" {
  name                  = local.metadata.name
  path                  = var.path
  description           = var.description
  max_session_duration  = var.max_session_duration
  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.permissions_boundary

  assume_role_policy = data.aws_iam_policy_document.trusted_entities.json

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# IAM Policy for Trusted Entities
###################################################

data "aws_iam_policy_document" "trusted_entities" {
  source_policy_documents = concat(
    values(data.aws_iam_policy_document.trusted_iam_entity_policies)[*].json,
    values(data.aws_iam_policy_document.trusted_service_policies)[*].json,
    values(data.aws_iam_policy_document.trusted_oidc_provider_policies)[*].json,
    values(data.aws_iam_policy_document.trusted_saml_provider_policies)[*].json,
  )
}


###################################################
# IAM Policy for AssumeRole
###################################################

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = var.assumable_roles
  }
}

resource "aws_iam_role_policy" "assume_role" {
  count = length(var.assumable_roles) > 0 ? 1 : 0

  role   = aws_iam_role.this.id
  name   = "assume-role"
  policy = data.aws_iam_policy_document.assume_role.json
}


###################################################
# IAM Instance Profile
###################################################

resource "aws_iam_instance_profile" "this" {
  count = var.instance_profile.enabled ? 1 : 0

  role = aws_iam_role.this.name

  name = coalesce(var.instance_profile.name, local.metadata.name)
  path = var.instance_profile.path

  tags = merge(
    {
      "Name" = coalesce(var.instance_profile.name, local.metadata.name)
    },
    local.module_tags,
    var.tags,
    var.instance_profile.tags,
  )
}
