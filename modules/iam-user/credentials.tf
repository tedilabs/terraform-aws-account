###################################################
# Login Profile for IAM User
###################################################

resource "aws_iam_user_login_profile" "this" {
  count = var.console_access.enabled ? 1 : 0

  user    = aws_iam_user.this.name
  pgp_key = var.pgp_key

  password_length         = var.console_access.password_length
  password_reset_required = var.console_access.password_reset_required

  lifecycle {
    ignore_changes = [
      pgp_key,
      password_length,
      password_reset_required,
    ]
  }
}


###################################################
# Access Keys for IAM User
###################################################

resource "aws_iam_access_key" "this" {
  count = length(var.access_keys)

  user    = aws_iam_user.this.name
  pgp_key = var.pgp_key

  status = var.access_keys[count.index].enabled ? "Active" : "Inactive"

  lifecycle {
    ignore_changes = [
      pgp_key,
    ]
  }
}


###################################################
# SSH Keys for IAM User
###################################################

resource "aws_iam_user_ssh_key" "this" {
  for_each = {
    for ssh_key in var.ssh_keys :
    md5(ssh_key.public_key) => ssh_key
  }

  username = aws_iam_user.this.name

  public_key = each.value.public_key
  encoding   = each.value.encoding
  status     = each.value.enabled ? "Active" : "Inactive"
}


###################################################
# Service Specified Credentials for IAM User
###################################################

resource "aws_iam_service_specific_credential" "this" {
  for_each = {
    for credential in var.service_credentials :
    credential.service => credential
  }

  user_name = aws_iam_user.this.name

  service_name = each.key
  status       = each.value.enabled ? "Active" : "Inactive"
}


###################################################
# X.509 Signing Certificates for IAM User
###################################################

resource "aws_iam_signing_certificate" "this" {
  for_each = {
    for certificate in var.signing_certificates :
    md5(certificate.certificate) => certificate
  }

  user_name = aws_iam_user.this.name

  certificate_body = each.value.certificate
  status           = each.value.enabled ? "Active" : "Inactive"
}
