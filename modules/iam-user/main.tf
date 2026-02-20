locals {
  metadata = {
    package = "terraform-aws-account"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}


###################################################
# IAM User
###################################################

resource "aws_iam_user" "this" {
  name          = var.name
  path          = var.path
  force_destroy = var.force_destroy

  permissions_boundary = var.permissions_boundary

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}

resource "aws_iam_user_group_membership" "this" {
  user   = aws_iam_user.this.name
  groups = var.groups
}


###################################################
# IAM Policy for AssumeRole
###################################################

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
      "sts:SetSourceIdentity",
    ]
    resources = var.assumable_roles
  }
}

resource "aws_iam_user_policy" "assume_role" {
  count = length(var.assumable_roles) > 0 ? 1 : 0

  user   = aws_iam_user.this.name
  name   = "assume-role"
  policy = data.aws_iam_policy_document.assume_role.json
}
