output "arn" {
  description = "The ARN of the IAM user."
  value       = aws_iam_user.this.arn
}

output "id" {
  description = "The ID of the IAM user."
  value       = aws_iam_user.this.id
}

output "unique_id" {
  description = "The unique ID assigned by AWS."
  value       = aws_iam_user.this.unique_id
}

output "name" {
  description = "The user's name."
  value       = aws_iam_user.this.name
}

output "path" {
  description = "The path of the IAM user."
  value       = aws_iam_user.this.path
}

output "groups" {
  description = "A set of IAM Groups which the user is a member of."
  value       = aws_iam_user_group_membership.this.groups
}

output "pgp_key" {
  description = "PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted)."
  value       = var.pgp_key
}

# NOTE: terraform output encrypted_password | base64 --decode | keybase pgp decrypt
output "console_access" {
  description = "The information of the AWS console access and password for the user."
  value = {
    enabled            = var.console_access.enabled
    encrypted_password = one(aws_iam_user_login_profile.this[*].encrypted_password)
  }
}

# NOTE: terraform output encrypted_secret_access_key | base64 --decode | keybase pgp decrypt
output "access_keys" {
  description = "The list of IAM Access Keys for the user."
  value = [
    for access_key in aws_iam_access_key.this : {
      id                          = access_key.id
      encrypted_secret_access_key = access_key.encrypted_secret
      encrypted_ses_smtp_password = access_key.encrypted_ses_smtp_password_v4
      secret_access_key           = access_key.secret
      ses_smtp_password           = access_key.ses_smtp_password_v4
      created_at                  = access_key.create_date
      enabled                     = access_key.status == "Active"
    }
  ]
}

output "ssh_keys" {
  description = "The list of SSH public keys for the user."
  value = [
    for ssh_key in aws_iam_user_ssh_key.this : {
      id = ssh_key.ssh_public_key_id

      encoding    = ssh_key.encoding
      public_key  = ssh_key.public_key
      fingerprint = ssh_key.fingerprint
      enabled     = ssh_key.status == "Active"
    }
  ]
}

output "service_credentials" {
  description = "The list of service specific credentials for the user."
  value = {
    for service, credential in aws_iam_service_specific_credential.this :
    service => {
      id       = credential.service_specific_credential_id
      username = credential.service_user_name
      password = credential.service_password
      enabled  = credential.status == "Active"
    }
  }
}

output "assumable_roles" {
  description = "A set of ARNs of IAM roles which IAM user can assume."
  value       = toset(var.assumable_roles)
}

output "exclusive_policy_management_enabled" {
  description = "Whether exclusive policy management is enabled for the IAM user."
  value       = var.exclusive_policy_management_enabled
}

output "exclusive_inline_policy_management_enabled" {
  description = "Whether exclusive inline policy management is enabled for the IAM user."
  value       = var.exclusive_inline_policy_management_enabled
}

output "policies" {
  description = "A set of ARNs of IAM policies which are atached to IAM user."
  value = (var.exclusive_policy_management_enabled
    ? toset(aws_iam_user_policy_attachments_exclusive.this[0].policy_arns)
    : toset(values(aws_iam_user_policy_attachment.managed)[*].policy_arn)
  )
}

output "inline_policies" {
  description = "A set of names of inline IAM polices which are attached to IAM user."
  value       = toset(keys(var.inline_policies))
}

