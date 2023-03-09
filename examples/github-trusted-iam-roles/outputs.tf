output "oidc_providers" {
  description = "A list of IAM OIDC Identity Providers."
  value       = module.oidc_provider
}

output "roles" {
  description = "A list of IAM Roles."
  value       = module.role
}
