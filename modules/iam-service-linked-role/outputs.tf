output "aws_service" {
  description = "The AWS service principal to which this role is attached."
  value       = aws_iam_service_linked_role.this.aws_service_name
}

output "name" {
  description = "IAM Role name."
  value       = aws_iam_service_linked_role.this.name
}

output "arn" {
  description = "The ARN assigned by AWS for this role."
  value       = aws_iam_service_linked_role.this.arn
}

output "unique_id" {
  description = "The unique ID assigned by AWS."
  value       = aws_iam_service_linked_role.this.unique_id
}

output "path" {
  description = "The path of the role."
  value       = aws_iam_service_linked_role.this.path
}

output "description" {
  description = "The description of the role."
  value       = aws_iam_service_linked_role.this.description
}

output "created_at" {
  description = "The creation date of the IAM role."
  value       = aws_iam_service_linked_role.this.create_date
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
