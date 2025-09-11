###################################################
# Managed Policies of IAM Group
###################################################

resource "aws_iam_group_policy_attachment" "managed" {
  for_each = var.exclusive_policy_management_enabled ? [] : toset(var.policies)

  group      = aws_iam_group.this.id
  policy_arn = each.key
}

resource "aws_iam_group_policy_attachments_exclusive" "this" {
  count = var.exclusive_policy_management_enabled ? 1 : 0

  group_name  = aws_iam_group.this.name
  policy_arns = var.policies
}


###################################################
# Inline Policies of IAM Group
###################################################

resource "aws_iam_group_policy" "inline" {
  for_each = var.exclusive_inline_policy_management_enabled ? {} : var.inline_policies

  group  = aws_iam_group.this.id
  name   = each.key
  policy = each.value
}

resource "aws_iam_group_policies_exclusive" "this" {
  count = var.exclusive_inline_policy_management_enabled ? 1 : 0

  group_name   = aws_iam_group.this.name
  policy_names = keys(var.inline_policies)
}
