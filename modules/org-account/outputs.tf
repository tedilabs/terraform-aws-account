output "name" {
  description = "The name of this account."
  value       = aws_organizations_account.this.name
}

output "email" {
  description = "The email address of this account."
  value       = aws_organizations_account.this.email
}

output "id" {
  description = "The ID of this account."
  value       = aws_organizations_account.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of this account."
  value       = aws_organizations_account.this.arn
}

output "parent_id" {
  description = "The ID of the parent Organizational Unit."
  value       = aws_organizations_account.this.parent_id
}

output "iam_user_access_to_billing_allowed" {
  description = "Whether accessing account billing information by IAM User is allowed."
  value       = var.iam_user_access_to_billing_allowed
}

output "preconfigured_adminitrator_role_name" {
  description = "The name of an IAM role that allow users in the master account to assume as administrator."
  value       = var.preconfigured_adminitrator_role_name
}

output "delegated_services" {
  description = "The method how this account joined to the organization."
  value = {
    for name, service in aws_organizations_delegated_administrator.this :
    name => {
      name       = name
      enabled_at = service.delegation_enabled_date
    }
  }
}

output "created_by" {
  description = "The method how this account joined to the organization."
  value       = aws_organizations_account.this.joined_method
}

output "created_at" {
  description = "The datetime which this account joined to the organization."
  value       = aws_organizations_account.this.joined_timestamp
}
