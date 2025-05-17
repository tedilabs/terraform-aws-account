###################################################
# Managed Policies of IAM User
###################################################

resource "aws_iam_user_policy_attachment" "managed" {
  for_each = var.exclusive_policy_management_enabled ? [] : toset(var.policies)

  user       = aws_iam_user.this.name
  policy_arn = each.key
}

resource "aws_iam_user_policy_attachments_exclusive" "this" {
  count = var.exclusive_policy_management_enabled ? 1 : 0

  user_name   = aws_iam_user.this.name
  policy_arns = var.policies
}


###################################################
# Inline Policies of IAM User
###################################################

resource "aws_iam_user_policy" "inline" {
  for_each = var.inline_policies

  user   = aws_iam_user.this.name
  name   = each.key
  policy = each.value
}

resource "aws_iam_user_policies_exclusive" "this" {
  count = var.exclusive_inline_policy_management_enabled ? 1 : 0

  user_name    = aws_iam_user.this.name
  policy_names = keys(var.inline_policies)
}