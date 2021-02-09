output "name" {
  description = "IAM group name."
  value       = aws_iam_group.this.name
}

output "arn" {
  description = "The ARN assigned by AWS for this group."
  value       = aws_iam_group.this.arn
}

output "unique_id" {
  description = "The unique ID assigned by AWS."
  value       = aws_iam_group.this.unique_id
}

output "assumable_roles" {
  description = "List of ARNs of IAM roles which members of IAM group can assume."
  value       = var.assumable_roles
}

output "policies" {
  description = "List of ARNs of IAM policies which are atached to IAM group."
  value       = var.policies
}

output "inline_policies" {
  description = "List of names of inline IAM polices which are attached to IAM group."
  value       = keys(var.inline_policies)
}
