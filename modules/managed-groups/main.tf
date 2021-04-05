locals {
  groups = {
    "self-service-password" = {
      enabled         = var.self_service_password_enabled
      name            = var.self_service_password_name
      assumable_roles = []
      inline_policies = {
        "self-service-password" = data.aws_iam_policy_document.self_service_password.json
      }
    }
    "self-service-mfa" = {
      enabled         = var.self_service_mfa_enabled
      name            = var.self_service_mfa_name
      assumable_roles = []
      inline_policies = {
        "self-service-mfa" = data.aws_iam_policy_document.self_service_mfa.json
      }
    }
  }
  enabled_groups = {
    for id, group in local.groups :
    id => group
    if group.enabled
  }
}


###################################################
# Resources
###################################################

module "groups" {
  source = "../iam-group"

  for_each = local.enabled_groups

  name = each.value.name != "" ? each.value.name : each.key
  path = "/managed/"

  assumable_roles = each.value.assumable_roles
  inline_policies = each.value.inline_policies
}


###################################################
# IAM Policies
###################################################

data "aws_caller_identity" "this" {}

## self-service-password
data "aws_iam_policy_document" "self_service_password" {
  statement {
    sid       = "GetAccountPasswordPolicy"
    effect    = "Allow"
    actions   = ["iam:GetAccountPasswordPolicy"]
    resources = ["*"]
  }
  statement {
    sid       = "ChangePassword"
    effect    = "Allow"
    actions   = ["iam:ChangePassword"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.this.account_id}:user/$${aws:username}"]
  }
}

## self-service-mfa
data "aws_iam_policy_document" "self_service_mfa" {
  statement {
    sid    = "AllowListActions"
    effect = "Allow"
    actions = [
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
    ]
    resources = ["*"]
  }
  statement {
    sid     = "AllowIndividualUserToListOnlyTheirOwnMFA"
    effect  = "Allow"
    actions = ["iam:ListMFADevices"]
    resources = [
      "arn:aws:iam::*:mfa/*",
      "arn:aws:iam::*:user/$${aws:username}"
    ]
  }
  statement {
    sid    = "AllowIndividualUserToManageTheirOwnMFA"
    effect = "Allow"
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
    ]
    resources = [
      "arn:aws:iam::*:mfa/$${aws:username}",
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }
  statement {
    sid     = "AllowIndividualUserToDeactivateOnlyTheirOwnMFAOnlyWhenUsingMFA"
    effect  = "Allow"
    actions = ["iam:DeactivateMFADevice"]
    resources = [
      "arn:aws:iam::*:mfa/$${aws:username}",
      "arn:aws:iam::*:user/$${aws:username}",
    ]
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
  statement {
    sid    = "BlockMostAccessUnlessSignedInWithMFA"
    effect = "Deny"
    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
    ]
    resources = ["*"]
    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
  }
}
