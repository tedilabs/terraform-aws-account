###################################################
# IAM Group
###################################################

resource "aws_iam_group" "this" {
  name = var.name
  path = var.path
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

resource "aws_iam_group_policy" "assume_role" {
  count = length(var.assumable_roles) > 0 ? 1 : 0

  group  = aws_iam_group.this.id
  name   = "assume-role"
  policy = data.aws_iam_policy_document.assume_role.json
}
