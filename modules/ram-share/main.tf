locals {
  metadata = {
    package = "terraform-aws-account"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}

locals {
  permission_arns = [
    for permission in var.permissions :
    "arn:aws:ram::aws:permission/${permission}"
  ]
}

resource "aws_ram_resource_share" "this" {
  name = var.name

  allow_external_principals = var.external_principals_allowed
  permission_arns           = local.permission_arns

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Principal Associations
###################################################

resource "aws_ram_principal_association" "this" {
  for_each = toset(var.principals)

  resource_share_arn = aws_ram_resource_share.this.arn
  principal          = each.value
}


###################################################
# Resource Associations
###################################################

resource "aws_ram_resource_association" "this" {
  for_each = toset(var.resources)

  resource_share_arn = aws_ram_resource_share.this.arn
  resource_arn       = each.value
}
