data "aws_caller_identity" "this" {}
data "aws_partition" "this" {}

locals {
  account_id = data.aws_caller_identity.this.account_id
  partition  = data.aws_partition.this.partition
}
