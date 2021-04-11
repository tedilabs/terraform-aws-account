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

resource "aws_iam_policy" "this" {
  for_each = {
    for item in var.enabled_policies :
    item.policy => item
  }

  name        = try(each.value.name, each.key)
  path        = try(each.value.path, "/managed/")
  description = try(each.value.description, "Managed by Terraform.")

  policy = file("${path.module}/policies/${each.key}.json")

  tags = merge(
    {
      "Name" = try(each.value.name, each.key)
    },
    local.module_tags,
    var.tags,
  )
}
