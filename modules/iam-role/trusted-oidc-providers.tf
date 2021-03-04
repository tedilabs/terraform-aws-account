data "aws_caller_identity" "this" {}
data "aws_partition" "this" {}

locals {
  oidc_provider_urls = {
    "google"      = "accounts.google.com"
    "facebook"    = "graph.facebook.com"
    "amazon"      = "www.amazon.com"
    "aws-cognito" = "cognito-identity.amazonaws.com"
  }
  oidc_arn_prefix = "arn:${data.aws_partition.this.partition}:iam::${data.aws_caller_identity.this.account_id}:oidc-provider/"
}

data "aws_iam_policy_document" "trusted_oidc_providers" {
  for_each = {
    for idx, provider in var.trusted_oidc_providers :
    idx + 1 => provider
  }

  statement {
    sid     = "TrustedOidcProviders${each.key}"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"
      identifiers = [
        each.value.type != "aws-iam"
        ? local.oidc_provider_urls[each.value.type]
        : "${local.oidc_arn_prefix}${each.value.url}"
      ]
    }

    dynamic "condition" {
      for_each = var.trusted_oidc_conditions

      content {
        variable = (
          each.value.type != "aws-iam"
          ? "${local.oidc_provider_urls[each.value.type]}:${condition.value.key}"
          : "${each.value.url}:${condition.value.key}"
        )
        test   = condition.value.condition
        values = condition.value.values
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
