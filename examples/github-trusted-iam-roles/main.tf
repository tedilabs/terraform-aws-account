provider "aws" {
  region = "us-east-1"
}


###################################################
# IAM OIDC Identity Providers
###################################################

locals {
  providers = [
    {
      url       = "https://token.actions.githubusercontent.com"
      audiences = ["sts.amazonaws.com"]
    },
  ]
}

module "oidc_provider" {
  source = "../../modules/iam-oidc-identity-provider"
  # source  = "tedilabs/account/aws//modules/iam-oidc-identity-provider"
  # version = "~> 0.23.0"

  for_each = {
    for provider in try(local.providers, []) :
    provider.url => provider
  }

  url       = each.key
  audiences = try(each.value.audiences, null)

  thumbprints             = try(each.value.thumbprints, null)
  auto_thumbprint_enabled = try(each.value.auto_thumbprint_enabled, true)

  tags = {
    "project" = "terraform-aws-account-examples"
  }
}


###################################################
# IAM Roles
###################################################

locals {
  roles = [
    {
      name     = "github-readonly"
      policies = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
    },
  ]
}

module "role" {
  source = "../../modules/iam-role"
  # source  = "tedilabs/account/aws//modules/iam-role"
  # version = "~> 0.23.0"

  for_each = {
    for role in try(local.roles, []) :
    role.name => role
  }

  name        = each.key
  description = try(each.value.description, "Managed by Terraform.")
  path        = try(each.value.path, "/")

  trusted_oidc_provider_policies = [
    {
      url = "token.actions.githubusercontent.com"
      conditions = [
        {
          key       = "aud"
          condition = "StringEquals"
          values    = ["sts.amazonaws.com"]
        },
        {
          key       = "sub"
          condition = "StringLike"
          values    = ["repo:tedilabs/*"]
        },
      ]
    }
  ]

  assumable_roles = try(each.value.assumable_roles, [])
  policies        = try(each.value.policies, [])
  inline_policies = {
    for name, path in try(each.value.inline_policies, {}) :
    name => file(path)
  }

  tags = {
    "project" = "terraform-aws-account-examples"
  }
}
