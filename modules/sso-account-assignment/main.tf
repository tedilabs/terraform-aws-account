locals {
  metadata = {
    package = "terraform-aws-account"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = "${var.account_id}/${data.aws_ssoadmin_permission_set.this.name}"
  }
}

data "aws_ssoadmin_instances" "this" {}

data "aws_ssoadmin_permission_set" "this" {
  instance_arn = local.sso_instance_arn
  arn          = var.permission_set_arn
}

data "aws_identitystore_group" "this" {
  for_each = toset(var.groups)

  identity_store_id = local.sso_identity_store_id

  filter {
    attribute_path  = "DisplayName"
    attribute_value = each.key
  }
}

data "aws_identitystore_user" "this" {
  for_each = toset(var.users)

  identity_store_id = local.sso_identity_store_id

  filter {
    attribute_path  = "UserName"
    attribute_value = each.key
  }
}

locals {
  sso_instance_arn      = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  sso_identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}


###################################################
# Account Assignments
###################################################

resource "aws_ssoadmin_account_assignment" "groups" {
  for_each = toset(var.groups)

  instance_arn = local.sso_instance_arn

  target_type = "AWS_ACCOUNT"
  target_id   = var.account_id

  permission_set_arn = var.permission_set_arn

  principal_type = "GROUP"
  principal_id   = data.aws_identitystore_group.this[each.key].group_id
}

resource "aws_ssoadmin_account_assignment" "users" {
  for_each = toset(var.users)

  instance_arn = local.sso_instance_arn

  target_type = "AWS_ACCOUNT"
  target_id   = var.account_id

  permission_set_arn = var.permission_set_arn

  principal_type = "USER"
  principal_id   = data.aws_identitystore_user.this[each.key].user_id
}
