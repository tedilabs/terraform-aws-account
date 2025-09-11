locals {
  resource_group_name = (var.resource_group.name != ""
    ? var.resource_group.name
    : join(".", [
      local.metadata.package,
      local.metadata.module,
      replace(local.metadata.name, "/[^a-zA-Z0-9_\\.-]/", "-"),
    ])
  )
}


module "resource_group" {
  source  = "tedilabs/misc/aws//modules/resource-group"
  version = "~> 0.12.0"

  count = (var.resource_group.enabled && var.module_tags_enabled) ? 1 : 0

  region = var.region

  name        = local.resource_group_name
  description = var.resource_group.description

  query = {
    resource_tags = local.module_tags
  }

  module_tags_enabled = false
  tags = merge(
    local.module_tags,
    var.tags,
  )
}
