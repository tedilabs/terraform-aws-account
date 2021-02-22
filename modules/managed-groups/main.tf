locals {
  groups = {
    "self-service-password" = {
      enabled = var.self_service_password_enabled
      name    = var.self_service_password_name
      assumable_roles = []
      inline_policies = {
        "change-password" = data.aws_iam_policy_document.change_password.json
      }
    }
  }
  enabled_groups = {
    for id, group in local.groups:
      id => group if group.enabled
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
data "aws_iam_policy_document" "change_password" {
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
