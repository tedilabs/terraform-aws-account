data "aws_iam_policy_document" "trusted_saml_providers" {
  for_each = {
    for provider in var.trusted_saml_providers :
    provider.name => provider
  }

  statement {
    sid     = "TrustedSAML${each.key}"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithSAML"]

    principals {
      type        = "Federated"
      identifiers = [each.value.arn]
    }

    dynamic "condition" {
      for_each = each.value.conditions

      content {
        variable = "saml:${condition.value.key}"
        test     = condition.value.condition
        values   = condition.value.values
      }
    }

    dynamic "condition" {
      for_each = var.conditions

      content {
        variable = condition.value.key
        test     = condition.value.condition
        values   = condition.value.values
      }
    }

    dynamic "condition" {
      for_each = var.effective_date != null ? ["go"] : []

      content {
        test     = "DateGreaterThan"
        variable = "aws:CurrentTime"
        values   = [var.effective_date]
      }
    }

    dynamic "condition" {
      for_each = var.expiration_date != null ? ["go"] : []

      content {
        test     = "DateLessThan"
        variable = "aws:CurrentTime"
        values   = [var.expiration_date]
      }
    }

    dynamic "condition" {
      for_each = length(var.source_ip_whitelist) > 0 ? ["go"] : []

      content {
        test     = "IpAddress"
        variable = "aws:SourceIp"
        values   = var.source_ip_whitelist
      }
    }

    dynamic "condition" {
      for_each = length(var.source_ip_blacklist) > 0 ? ["go"] : []

      content {
        test     = "NotIpAddress"
        variable = "aws:SourceIp"
        values   = var.source_ip_blacklist
      }
    }
  }
}
