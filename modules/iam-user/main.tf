resource "aws_iam_user" "this" {
  name                 = var.name
  path                 = var.path
  force_destroy        = var.force_destroy
  permissions_boundary = var.permissions_boundary

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}

resource "aws_iam_user_group_membership" "this" {
  user = aws_iam_user.this.name
  groups = var.groups
}

resource "aws_iam_user_login_profile" "this" {
  count = var.create_login_profile && var.pgp_key != "" ? 1 : 0

  user                    = aws_iam_user.this.name
  pgp_key                 = var.pgp_key
  password_length         = var.password_length
  password_reset_required = var.password_reset_required
}

resource "aws_iam_access_key" "this" {
  count = var.create_access_key && var.pgp_key != "" ? 1 : 0

  user    = aws_iam_user.this.name
  pgp_key = var.pgp_key
  status  = var.access_key_enabled ? "Active" : "Inactive"
}

resource "aws_iam_user_ssh_key" "this" {
  count = var.upload_ssh_key ? 1 : 0

  username   = aws_iam_user.this.name
  encoding   = var.ssh_public_key_encoding
  public_key = var.ssh_public_key
  status     = var.ssh_public_key_enabled ? "Active" : "Inactive"
}


###################################################
# IAM Policy for AssumeRole
###################################################

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = var.assumable_roles
  }
}

resource "aws_iam_user_policy" "assume_role" {
  count = length(var.assumable_roles) > 0 ? 1 : 0

  user   = aws_iam_user.this.name
  name   = "assume-role"
  policy = data.aws_iam_policy_document.assume_role.json
}


###################################################
# IAM Policy Attachment for Managed Policies
###################################################

resource "aws_iam_user_policy_attachment" "managed" {
  for_each = toset(var.policies)

  user       = aws_iam_user.this.name
  policy_arn = each.key
}


###################################################
# IAM Policy Attachment for Inline Policies
###################################################

resource "aws_iam_user_policy" "inline" {
  for_each = var.inline_policies

  user   = aws_iam_user.this.name
  name   = each.key
  policy = each.value
}
