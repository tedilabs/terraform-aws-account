locals {
  metadata = {
    package = "terraform-aws-account"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = local.region
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}

data "aws_region" "this" {}

locals {
  region = data.aws_region.this.name
  region_codes = {
    "us-east-1"      = "use1"
    "us-east-2"      = "use2"
    "us-gov-east-1"  = "usge1"
    "us-gov-west-1"  = "usgw1"
    "us-west-1"      = "usw1"
    "us-west-2"      = "usw2"
    "af-south-1"     = "afs1"
    "ap-east-1"      = "ape1"
    "ap-northeast-1" = "apne1"
    "ap-northeast-2" = "apne2"
    "ap-northeast-3" = "apne3"
    "ap-south-1"     = "aps1"
    "ap-south-2"     = "aps2"
    "ap-southeast-1" = "apse1"
    "ap-southeast-2" = "apse2"
    "ap-southeast-3" = "apse3"
    "ap-southeast-4" = "apse4"
    "ap-southeast-5" = "apse5"
    "ap-southeast-7" = "apse7"
    "ca-central-1"   = "cac1"
    "ca-west-1"      = "caw1"
    "cn-north-1"     = "cn1"
    "cn-northwest-1" = "cnw1"
    "eu-central-1"   = "euc1"
    "eu-central-2"   = "euc2"
    "eu-north-1"     = "eun1"
    "eu-south-1"     = "eus1"
    "eu-south-2"     = "eus2"
    "eu-west-1"      = "euw1"
    "eu-west-2"      = "euw2"
    "eu-west-3"      = "euw3"
    "il-central-1"   = "ilc1"
    "me-central-1"   = "mec1"
    "me-south-1"     = "mes1"
    "mx-central-1"   = "mxc1"
    "sa-east-1"      = "sae1"
  }
}
