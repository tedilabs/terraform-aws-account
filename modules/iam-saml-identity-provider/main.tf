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
# SAML Identity Provider
###################################################

resource "aws_iam_saml_provider" "this" {
  name                   = var.name
  saml_metadata_document = var.metadata_document

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
