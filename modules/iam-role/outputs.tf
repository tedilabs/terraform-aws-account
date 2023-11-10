output "name" {
  description = "IAM Role name."
  value       = aws_iam_role.this.name
}

output "arn" {
  description = "The ARN assigned by AWS for this role."
  value       = aws_iam_role.this.arn
}

output "unique_id" {
  description = "The unique ID assigned by AWS."
  value       = aws_iam_role.this.unique_id
}

output "description" {
  description = "The description of the role."
  value       = aws_iam_role.this.description
}

output "assumable_roles" {
  description = "List of ARNs of IAM roles which members of IAM role can assume."
  value       = var.assumable_roles
}

output "policies" {
  description = "List of ARNs of IAM policies which are atached to IAM role."
  value       = var.policies
}

output "inline_policies" {
  description = "List of names of inline IAM polices which are attached to IAM role."
  value       = keys(var.inline_policies)
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
      path       = aws_iam_instance_profile.this[1].path
      created_at = aws_iam_instance_profile.this[0].create_date
    }
    : null
  )
}
