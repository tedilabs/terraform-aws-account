output "name" {
  description = "The name of the Organization."
  value       = var.name
}

output "id" {
  description = "The ID of the Organization."
  value       = aws_organizations_organization.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the Organization."
  value       = aws_organizations_organization.this.arn
}

output "all_features_enabled" {
  description = "Whether AWS Organization was configured with all features or only consolidated billing feature."
  value       = var.all_features_enabled
}

output "ai_services_opt_out_policy_type_enabled" {
  description = "Whether AI services opt-out polices are enabled."
  value       = var.ai_services_opt_out_policy_type_enabled
}

output "backup_policy_type_enabled" {
  description = "Whether Backup polices are enabled."
  value       = var.backup_policy_type_enabled
}

output "service_control_policy_type_enabled" {
  description = "Whether Service control polices(SCPs) are enabled."
  value       = var.service_control_policy_type_enabled
}

output "tag_policy_type_enabled" {
  description = "Whether Tag polices are enabled."
  value       = var.tag_policy_type_enabled
}

output "trusted_access_enabled_service_principals" {
  description = "List of AWS service principal names which is integrated with the organization."
  value       = aws_organizations_organization.this.aws_service_access_principals
}

output "accounts" {
  description = "The accounts for the Organization."
  value       = aws_organizations_organization.this.accounts
}

output "master_account" {
  description = "The master account for the Organization."
  value = {
    id    = aws_organizations_organization.this.master_account_id
    arn   = aws_organizations_organization.this.master_account_arn
    email = aws_organizations_organization.this.master_account_email
  }
}

output "non_master_accounts" {
  description = "The non-master accounts for the Organization."
  value       = aws_organizations_organization.this.non_master_accounts
}

output "root" {
  description = "The root information of the Organization."
  value = {
    id   = aws_organizations_organization.this.roots[0].id
    arn  = aws_organizations_organization.this.roots[0].arn
    name = aws_organizations_organization.this.roots[0].name
  }
}
