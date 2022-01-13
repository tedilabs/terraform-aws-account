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
    values(data.aws_iam_policy_document.trusted_iam_entities)[*].json,
    values(data.aws_iam_policy_document.trusted_services)[*].json,
    values(data.aws_iam_policy_document.trusted_oidc_providers)[*].json,
    values(data.aws_iam_policy_document.trusted_saml_providers)[*].json,
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
# IAM Policy Attachment for Managed Policies
###################################################

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset(var.policies)

  role       = aws_iam_role.this.id
  policy_arn = each.key
}


###################################################
# IAM Policy Attachment for Inline Policies
###################################################

resource "aws_iam_role_policy" "inline" {
  for_each = var.inline_policies

  role   = aws_iam_role.this.id
  name   = each.key
  policy = each.value
}


###################################################
# IAM Instance Profile
###################################################

resource "aws_iam_instance_profile" "this" {
  count = var.instance_profile_enabled ? 1 : 0

  role = aws_iam_role.this.name
  name = local.metadata.name
  path = var.path

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
