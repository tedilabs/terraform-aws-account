locals {
  metadata = {
    package = "terraform-aws-account"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = basename(path.module)
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
# IAM Predefined Policies
###################################################

module "iam_policy" {
  source = "../iam-policy"

  for_each = {
    for item in var.enabled_policies :
    item.policy => item
  }

  name        = coalesce(each.value.name, each.key)
  path        = each.value.path
  description = each.value.description

  policy = file("${path.module}/policies/${each.key}.json")

  resource_group = {
    enabled = false
  }

  tags = merge(
    {
      "Name" = coalesce(each.value.name, each.key)
    },
    local.module_tags,
    var.tags,
  )
}
