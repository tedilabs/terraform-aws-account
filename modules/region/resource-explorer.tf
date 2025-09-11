locals {
  resource_explorer_views = (var.resource_explorer.enabled
    ? var.resource_explorer.views
    : []
  )
}


###################################################
# Resource Explorer
###################################################

resource "aws_resourceexplorer2_index" "this" {
  count = var.resource_explorer.enabled ? 1 : 0

  region = var.region

  type = var.resource_explorer.index_type

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}

resource "aws_resourceexplorer2_view" "this" {
  for_each = {
    for view in local.resource_explorer_views :
    view.name => view
  }

  region = aws_resourceexplorer2_index.this[0].region

  name         = each.key
  default_view = each.value.is_default
  scope        = each.value.scope

  dynamic "filters" {
    for_each = each.value.filter_queries
    iterator = query

    content {
      filter_string = query.value
    }
  }

  dynamic "included_property" {
    for_each = each.value.additional_resource_attributes
    iterator = attribute

    content {
      name = attribute.value
    }
  }

  tags = merge(
    {
      "Name" = each.key
    },
    local.module_tags,
    var.tags,
  )
}
