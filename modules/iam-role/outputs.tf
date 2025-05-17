output "arn" {
  description = "The ARN of the IAM role."
  value       = aws_iam_role.this.arn
}

output "id" {
  description = "The ID of the IAM role."
  value       = aws_iam_role.this.id
}

output "unique_id" {
  description = "The unique ID assigned by AWS."
  value       = aws_iam_role.this.unique_id
}

output "name" {
  description = "IAM Role name."
  value       = aws_iam_role.this.name
}

output "description" {
  description = "The description of the role."
  value       = aws_iam_role.this.description
}

output "path" {
  description = "The path of the IAM role."
  value       = aws_iam_role.this.path
}

output "assumable_roles" {
  description = "A set of ARNs of IAM roles which members of IAM role can assume."
  value       = toset(var.assumable_roles)
}

output "exclusive_policy_management_enabled" {
  description = "Whether exclusive policy management is enabled for the IAM role."
  value       = var.exclusive_policy_management_enabled
}

output "exclusive_inline_policy_management_enabled" {
  description = "Whether exclusive inline policy management is enabled for the IAM role."
  value       = var.exclusive_inline_policy_management_enabled
}

output "policies" {
  description = "A set of ARNs of IAM policies which are atached to IAM role."
  value = (var.exclusive_policy_management_enabled
    ? toset(aws_iam_role_policy_attachments_exclusive.this[0].policy_arns)
    : toset(values(aws_iam_role_policy_attachment.managed)[*].policy_arn)
  )
}

output "inline_policies" {
  description = "A set of names of inline IAM polices which are attached to IAM role."
  value       = toset(keys(var.inline_policies))
}

output "created_at" {
  description = "Creation date of the IAM role."
  value       = aws_iam_role.this.create_date
}

output "instance_profile" {
  description = <<EOF
  The instance profile associated with the IAM Role.
    `id` - The instance profile's ID.
    `arn` - The ARN assigned by AWS for the instance profile.
    `name` - The name of the instance profile.
    `path` - The path to the instance profile.
    `created_at` - Creation timestamp of the instance profile.
  EOF
  value = (var.instance_profile.enabled
    ? {
      id         = aws_iam_instance_profile.this[0].unique_id
      arn        = aws_iam_instance_profile.this[0].arn
      name       = aws_iam_instance_profile.this[0].name
      path       = aws_iam_instance_profile.this[0].path
      created_at = aws_iam_instance_profile.this[0].create_date
    }
    : null
  )
}
