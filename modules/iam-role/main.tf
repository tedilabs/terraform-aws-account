resource "aws_iam_role" "this" {
  name                  = var.name
  path                  = var.path
  description           = var.description
  max_session_duration  = var.max_session_duration
  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.permissions_boundary

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}


###################################################
# IAM Policy for AssumeRole
###################################################

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = var.trusted_iam_entities
    }

    principals {
      type        = "Service"
      identifiers = var.trusted_services
    }

    dynamic "condition" {
      for_each = var.mfa_required ? ["go"] : []

      content {
        test     = "Bool"
        variable = "aws:MultiFactorAuthPresent"
        values   = [tostring(var.mfa_required)]
      }
    }

    dynamic "condition" {
      for_each = var.mfa_required ? ["go"] : []

      content {
        test     = "NumericLessThan"
        variable = "aws:MultiFactorAuthAge"
        values   = [var.mfa_ttl]
      }
    }
  }
}


###################################################
# IAM Policy Attachment for Managed Policies
###################################################

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset(var.policies)

  role       = aws_iam_role.this.id
  policy_arn = each.key
}


###################################################
# IAM Policy Attachment for Inline Policies
###################################################

resource "aws_iam_role_policy" "inline" {
  for_each = var.inline_policies

  role   = aws_iam_role.this.id
  name   = each.key
  policy = each.value
}


###################################################
# IAM Instance Profile
###################################################

resource "aws_iam_instance_profile" "this" {
  count = var.instance_profile_enabled ? 1 : 0

  role = aws_iam_role.this.name
  name = var.name
  path = var.path
}
