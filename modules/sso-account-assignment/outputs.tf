output "name" {
  description = "The name of the Account Assignment."
  value       = local.metadata.name
}

output "account_id" {
  description = "The identifier of an AWS account."
  value       = var.account_id
}

output "permission_set" {
  description = "The Amazon Resource Name (ARN) of the Permission Set"
  value       = var.permission_set_arn
}

output "instance_arn" {
  description = "The Amazon Resource Name (ARN) of the SSO Instance."
  value       = local.sso_instance_arn
}

output "identity_store_id" {
  description = "The ID of SSO Identity Store."
  value       = local.sso_identity_store_id
}

output "group_assignments" {
  description = "List of groups who can access to the Permission Set."
  value = [
    for name, group in aws_ssoadmin_account_assignment.groups : {
      id   = group.principal_id
      name = name
    }
  ]
}

output "user_assignments" {
  description = "List of users who can access to the Permission Set."
  value = [
    for name, user in aws_ssoadmin_account_assignment.users : {
      id   = user.principal_id
      name = name
    }
  ]
}
