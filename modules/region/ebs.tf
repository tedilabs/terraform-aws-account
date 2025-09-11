###################################################
# Default Encryption for EBS
###################################################

resource "aws_ebs_encryption_by_default" "this" {
  region = var.region

  enabled = var.ebs.default_encryption.enabled
}

resource "aws_ebs_default_kms_key" "this" {
  count = var.ebs.default_encryption.kms_key != null ? 1 : 0

  region = var.region

  key_arn = var.ebs.default_encryption.kms_key
}


###################################################
# Public Access Block for EBS Snapshots
###################################################

resource "aws_ebs_snapshot_block_public_access" "this" {
  region = var.region

  state = var.ebs.snapshot_public_access_mode
}
