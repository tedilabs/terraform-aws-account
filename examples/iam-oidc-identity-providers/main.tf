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
