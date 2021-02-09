resource "aws_iam_group" "this" {
  name = var.name
  path = var.path
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

resource "aws_iam_group_policy" "assume_role" {
  count = length(var.assumable_roles) > 0 ? 1 : 0

  group  = aws_iam_group.this.id
  name   = "assume-role"
  policy = data.aws_iam_policy_document.assume_role.json
}


###################################################
# IAM Policy Attachment for Managed Policies
###################################################

resource "aws_iam_group_policy_attachment" "managed" {
  for_each = toset(var.policies)

  group      = aws_iam_group.this.id
  policy_arn = each.key
}


###################################################
# IAM Policy Attachment for Inline Policies
###################################################

resource "aws_iam_group_policy" "inline" {
  for_each = var.inline_policies

  group  = aws_iam_group.this.id
  name   = each.key
  policy = each.value
}
