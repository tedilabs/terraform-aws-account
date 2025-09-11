###################################################
# Managed Policies of IAM Role
###################################################

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = var.exclusive_policy_management_enabled ? [] : toset(var.policies)

  role       = aws_iam_role.this.id
  policy_arn = each.key
}

resource "aws_iam_role_policy_attachments_exclusive" "this" {
  count = var.exclusive_policy_management_enabled ? 1 : 0

  role_name   = aws_iam_role.this.name
  policy_arns = var.policies
}


###################################################
# Inline Policies of IAM Role
###################################################

resource "aws_iam_role_policy" "inline" {
  for_each = var.exclusive_inline_policy_management_enabled ? {} : var.inline_policies

  role   = aws_iam_role.this.id
  name   = each.key
  policy = each.value
}

resource "aws_iam_role_policies_exclusive" "this" {
  count = var.exclusive_inline_policy_management_enabled ? 1 : 0

  role_name    = aws_iam_role.this.name
  policy_names = keys(var.inline_policies)
}
