output "id" {
  description = "The ID of this IAM policy."
  value       = aws_iam_policy.this.policy_id
}

output "arn" {
  description = "The ARN assigned by AWS for this IAM policy."
  value       = aws_iam_policy.this.arn
}

output "name" {
  description = "The URL of the IAM policy."
  value       = aws_iam_policy.this.name
}

output "path" {
  description = "The path of the IAM policy."
  value       = aws_iam_policy.this.path
}

output "description" {
  description = "The description of the IAM policy."
  value       = aws_iam_policy.this.description
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
