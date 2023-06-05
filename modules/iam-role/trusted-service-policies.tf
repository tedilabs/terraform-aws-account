data "aws_iam_policy_document" "trusted_service_policies" {
  for_each = {
    for idx, policy in var.trusted_service_policies :
    idx => policy
  }

  statement {
    sid     = "TrustedServices${each.key}"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = each.value.services
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
      for_each = each.value.conditions

      content {
        variable = condition.value.key
        test     = condition.value.condition
        values   = condition.value.values
      }
    }

    dynamic "condition" {
      for_each = each.value.effective_date != null ? ["go"] : []

      content {
        test     = "DateGreaterThan"
        variable = "aws:CurrentTime"
        values   = [each.value.effective_date]
      }
    }

    dynamic "condition" {
      for_each = each.value.expiration_date != null ? ["go"] : []

      content {
        test     = "DateLessThan"
        variable = "aws:CurrentTime"
        values   = [each.value.expiration_date]
      }
    }

    dynamic "condition" {
      for_each = length(each.value.source_ip_whitelist) > 0 ? ["go"] : []

      content {
        test     = "IpAddress"
        variable = "aws:SourceIp"
        values   = each.value.source_ip_whitelist
      }
    }

    dynamic "condition" {
      for_each = length(each.value.source_ip_blacklist) > 0 ? ["go"] : []

      content {
        test     = "NotIpAddress"
        variable = "aws:SourceIp"
        values   = each.value.source_ip_blacklist
      }
    }
  }

  dynamic "statement" {
    for_each = var.trusted_session_tagging.enabled ? ["go"] : []

    content {
      sid     = "TrustedTagSessionForServices${each.key}"
      effect  = "Allow"
      actions = ["sts:TagSession"]

      principals {
        type        = "Service"
        identifiers = each.value.services
      }

      dynamic "condition" {
        for_each = var.trusted_session_tagging.allowed_tags

        content {
          test     = "StringLike"
          variable = "aws:RequestTag/${condition.key}"
          values   = condition.value.values
        }
      }

      dynamic "condition" {
        for_each = length(var.trusted_session_tagging.allowed_transitive_tag_keys) > 0 ? ["go"] : []

        content {
          test     = "ForAllValues:StringLike"
          variable = "sts:TransitiveTagKeys"
          values   = var.trusted_session_tagging.allowed_transitive_tag_keys
        }
      }
    }
  }

  dynamic "statement" {
    for_each = var.trusted_source_identity.enabled ? ["go"] : []

    content {
      sid     = "TrustedSourceIdentityForServices${each.key}"
      effect  = "Allow"
      actions = ["sts:SetSourceIdentity"]

      principals {
        type        = "Service"
        identifiers = each.value.services
      }

      dynamic "condition" {
        for_each = length(var.trusted_source_identity.allowed_identities) > 0 ? ["go"] : []

        content {
          test     = "StringLike"
          variable = "sts:SourceIdentity"
          values   = var.trusted_source_identity.allowed_identities
        }
      }
    }
  }
}
