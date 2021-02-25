output "name" {
  description = "The user's name."
  value       = aws_iam_user.this.name
}

output "arn" {
  description = "The ARN assigned by AWS for this user."
  value       = aws_iam_user.this.arn
}

output "unique_id" {
  description = "The unique ID assigned by AWS."
  value       = aws_iam_user.this.unique_id
}

output "groups" {
  description = "The list of IAM Groups."
  value       = aws_iam_user_group_membership.this.groups
}

output "pgp_key" {
  description = "PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted)."
  value       = var.pgp_key
}

output "key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password."
  value = element(
    concat(aws_iam_user_login_profile.this.*.key_fingerprint, [""]),
    0,
  )
}

# NOTE: terraform output encrypted_password | base64 --decode | keybase pgp decrypt
output "encrypted_password" {
  description = "The encrypted password, base64 encoded."
  value = element(
    concat(aws_iam_user_login_profile.this.*.encrypted_password, [""]),
    0,
  )
}

output "access_key_id" {
  description = "The access key ID."
  value       = element(concat(aws_iam_access_key.this.*.id, [""]), 0)
}

# NOTE: terraform output encrypted_secret_access_key | base64 --decode | keybase pgp decrypt
output "encrypted_secret_access_key" {
  description = "The encrypted secret, base64 encoded."
  value       = element(concat(aws_iam_access_key.this.*.encrypted_secret, [""]), 0)
}

output "ses_smtp_password" {
  description = "The secret access key converted into an SES SMTP password."
  value       = element(concat(aws_iam_access_key.this.*.ses_smtp_password_v4, [""]), 0)
}

output "access_key_status" {
  description = "Active or Inactive. Keys are initially active, but can be made inactive by other means."
  value       = element(concat(aws_iam_access_key.this.*.status, [""]), 0)
}

output "ssh_public_key_id" {
  description = "The unique identifier for the SSH public key."
  value       = element(concat(aws_iam_user_ssh_key.this.*.ssh_public_key_id, [""]), 0)
}

output "ssh_public_key_fingerprint" {
  description = "The MD5 message digest of the SSH public key."
  value       = element(concat(aws_iam_user_ssh_key.this.*.fingerprint, [""]), 0)
}

output "assumable_roles" {
  description = "List of ARNs of IAM roles which IAM user can assume."
  value       = var.assumable_roles
}

output "policies" {
  description = "List of ARNs of IAM policies which are atached to IAM user."
  value       = var.policies
}

output "inline_policies" {
  description = "List of names of inline IAM polices which are attached to IAM user."
  value       = keys(var.inline_policies)
}
