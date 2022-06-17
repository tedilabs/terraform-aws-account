###################################################
# Account-level Public Access Block for S3
###################################################

resource "aws_s3_account_public_access_block" "this" {
  account_id = data.aws_caller_identity.this.account_id

  block_public_acls       = !var.s3_public_access_enabled
  block_public_policy     = !var.s3_public_access_enabled
  ignore_public_acls      = !var.s3_public_access_enabled
  restrict_public_buckets = !var.s3_public_access_enabled
}
