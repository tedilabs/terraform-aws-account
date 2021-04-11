output "policies" {
  description = "List of policies which are managed by this module."
  value       = aws_iam_policy.this
}
