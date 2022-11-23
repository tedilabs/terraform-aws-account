provider "aws" {
  region = "us-east-1"
}


###################################################
# IAM SAML Identity Providers
###################################################

locals {
  providers = [
    {
      name              = "test"
      metadata_document = file("${path.module}/saml-idp-metadata.xml")
    },
  ]
}

module "saml_provider" {
  source = "../../modules/iam-saml-identity-provider"
  # source  = "tedilabs/account/aws//modules/iam-saml-identity-provider"
  # version = "~> 0.23.0"

  for_each = {
    for provider in try(local.providers, []) :
    provider.name => provider
  }

  name              = each.key
  metadata_document = each.value.metadata_document

  tags = {
    "project" = "terraform-aws-account-examples"
  }
}
