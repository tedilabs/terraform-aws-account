output "policies" {
  description = "A list of policies which are managed by this module."
  value = {
    for name, policy in aws_iam_policy.this :
    name => {
      id          = policy.id
      arn         = policy.arn
      name        = policy.name
      path        = policy.path
      description = policy.description
    }
  }
}

output "resource_group" {
  description = "The resource group created to manage resources in this module."
  value = merge(
    {
      enabled = var.resource_group.enabled && var.module_tags_enabled
    },
    (var.resource_group.enabled && var.module_tags_enabled
      ? {
        arn  = module.resource_group[0].arn
        name = module.resource_group[0].name
      }
      : {}
    )
  )
}
