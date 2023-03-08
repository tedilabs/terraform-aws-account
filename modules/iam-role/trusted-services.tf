data "aws_iam_policy_document" "trusted_services" {
  for_each = toset(
    length(var.trusted_services) > 0 ? ["this"] : []
  )

  statement {
    sid     = "TrustedServices"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.trusted_services
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

  dynamic "statement" {
    for_each = var.trusted_session_tagging.enabled ? ["go"] : []

    content {
      sid     = "TrustedTagSession"
      effect  = "Allow"
      actions = ["sts:TagSession"]

      principals {
        type        = "Service"
        identifiers = var.trusted_services
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
      sid     = "TrustedSourceIdentity"
      effect  = "Allow"
      actions = ["sts:SetSourceIdentity"]

      principals {
        type        = "Service"
        identifiers = var.trusted_services
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
