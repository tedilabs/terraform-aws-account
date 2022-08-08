output "name" {
  description = "The name of the Permission Set."
  value       = aws_ssoadmin_permission_set.this.name
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the Permission Set."
  value       = aws_ssoadmin_permission_set.this.arn
}

output "instance_arn" {
  description = "The Amazon Resource Name (ARN) of the SSO Instance."
  value       = aws_ssoadmin_permission_set.this.instance_arn
}

output "session_duration" {
  description = "The length of time that the application user sessions are valid in seconds."
  value       = aws_ssoadmin_permission_set.this.session_duration
}

output "relay_state" {
  description = "The relay state URL used to redirect users within the application during the federation authentication process."
  value       = aws_ssoadmin_permission_set.this.relay_state
}

output "managed_policies" {
  description = "List of ARNs of IAM managed policies which are attached to the Permission Set."
  value       = var.managed_policies
}

output "inline_policy" {
  description = "The IAM inline policy which are attached to the Permission Set."
  value       = var.inline_policy
}

output "created_at" {
  description = "The date the Permission Set was created in RFC3339 format."
  value       = aws_ssoadmin_permission_set.this.created_date
}
