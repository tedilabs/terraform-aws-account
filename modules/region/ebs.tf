###################################################
# Default Encryption for EBS
###################################################

resource "aws_ebs_encryption_by_default" "this" {
  enabled = var.ebs_default_encryption_enabled
}

resource "aws_ebs_default_kms_key" "this" {
  count = var.ebs_default_encryption_kms_key != null ? 1 : 0

  key_arn = var.ebs_default_encryption_kms_key
}
