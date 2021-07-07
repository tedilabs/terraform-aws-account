locals {
  resource_group_name = (var.resource_group_name != ""
    ? var.resource_group_name
    : join(".", [
      local.metadata.package,
      local.metadata.module,
      replace(local.metadata.name, "/[^a-zA-Z0-9_\\.-]/", "-"),
    ])
  )
  resource_group_filters = [
    for key, value in local.module_tags : {
      "Key"    = key
      "Values" = [value]
    }
  ]
  resource_group_query = <<-JSON
  {
    "ResourceTypeFilters": [
      "AWS::AllSupported"
    ],
    "TagFilters": ${jsonencode(local.resource_group_filters)}
  }
  JSON
}

resource "aws_resourcegroups_group" "this" {
  count = (var.resource_group_enabled && var.module_tags_enabled) ? 1 : 0

  name        = local.resource_group_name
  description = var.resource_group_description

  resource_query {
    type  = "TAG_FILTERS_1_0"
    query = local.resource_group_query
  }

  tags = merge(
    {
      "Name" = local.resource_group_name
    },
    local.module_tags,
    var.tags,
  )
}
