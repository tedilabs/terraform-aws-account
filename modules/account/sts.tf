locals {
  global_endpoint_token_version = {
    "v1" = "v1Token"
    "v2" = "v2Token"
  }
}


###################################################
# AWS STS (Security Token Service)
###################################################

resource "aws_iam_security_token_service_preferences" "this" {
  global_endpoint_token_version = local.global_endpoint_token_version[var.sts_global_endpoint_token_version]
}
