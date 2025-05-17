output "arn" {
  description = "The ARN of the IAM group."
  value       = aws_iam_group.this.arn
}

output "id" {
  description = "The ID of the IAM group."
  value       = aws_iam_group.this.id
}

output "unique_id" {
  description = "The unique ID assigned by AWS."
  value       = aws_iam_group.this.unique_id
}

output "name" {
  description = "The IAM group name."
  value       = aws_iam_group.this.name
}

output "path" {
  description = "The path of the IAM group."
  value       = aws_iam_group.this.path
}

output "assumable_roles" {
  description = "A set of ARNs of IAM roles which members of IAM group can assume."
  value       = toset(var.assumable_roles)
}

output "exclusive_policy_management_enabled" {
  description = "Whether exclusive policy management is enabled for the IAM group."
  value       = var.exclusive_policy_management_enabled
}

output "exclusive_inline_policy_management_enabled" {
  description = "Whether exclusive inline policy management is enabled for the IAM group."
  value       = var.exclusive_inline_policy_management_enabled
}

output "policies" {
  description = "A set of ARNs of IAM policies which are atached to IAM group."
  value = (var.exclusive_policy_management_enabled
    ? toset(aws_iam_group_policy_attachments_exclusive.this[0].policy_arns)
    : toset(values(aws_iam_group_policy_attachment.managed)[*].policy_arn)
  )
}

output "inline_policies" {
  description = "A set of names of inline IAM polices which are attached to IAM group."
  value       = toset(keys(var.inline_policies))
}
