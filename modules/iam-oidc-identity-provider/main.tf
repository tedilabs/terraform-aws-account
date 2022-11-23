locals {
  metadata = {
    package = "terraform-aws-account"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.url
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}


###################################################
# OIDC Identity Provider
###################################################

data "tls_certificate" "this" {
  count = var.auto_thumbprint_enabled ? 1 : 0

  url = var.url
}

resource "aws_iam_openid_connect_provider" "this" {
  url = var.url

  client_id_list = var.audiences
  thumbprint_list = setunion(
    var.thumbprints,
    (var.auto_thumbprint_enabled
      ? data.tls_certificate.this[*].certificates[0].sha1_fingerprint
      : []
    )
  )

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
