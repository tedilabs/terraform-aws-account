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
