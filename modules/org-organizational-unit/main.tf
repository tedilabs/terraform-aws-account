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

data "aws_organizations_organization" "this" {}

locals {
  organization_root_id = data.aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "this" {
  name      = var.name
  parent_id = coalesce(var.parent_id, local.organization_root_id)

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# AWS Managed Policies
###################################################

resource "aws_organizations_policy_attachment" "this" {
  for_each = toset(var.policies)

  target_id = aws_organizations_organizational_unit.this.id
  policy_id = each.key
}
