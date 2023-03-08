locals {
  oidc_provider_common_urls = [
    "accounts.google.com",
    "cognito-identity.amazonaws.com",
    "graph.facebook.com",
    "www.amazon.com",
  ]
  oidc_provider_arn_prefix = "arn:${local.partition}:iam::${local.account_id}:oidc-provider/"
}

data "aws_iam_policy_document" "trusted_oidc_providers" {
  for_each = {
    for idx, provider in var.trusted_oidc_providers :
    idx => provider
  }

  statement {
    sid     = "TrustedOIDC${each.key}"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"
      identifiers = [
        contains(local.oidc_provider_common_urls, each.value.url)
        ? each.value.url
        : "${local.oidc_provider_arn_prefix}${each.value.url}"
      ]
    }

    dynamic "condition" {
      for_each = each.value.conditions

      content {
        variable = "${each.value.url}:${condition.value.key}"
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

  dynamic "statement" {
    for_each = var.trusted_session_tagging.enabled ? ["go"] : []

    content {
      sid     = "TrustedTagSession${each.key}"
      effect  = "Allow"
      actions = ["sts:TagSession"]

      principals {
        type = "Federated"
        identifiers = [
          contains(local.oidc_provider_common_urls, each.value.url)
          ? each.value.url
          : "${local.oidc_provider_arn_prefix}${each.value.url}"
        ]
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
}
