locals {
  ec2_allowed_amis_mode = {
    "ENABLED"  = "enabled"
    "AUDIT"    = "audit-mode"
    "DISABLED" = "disabled"
  }
}


###################################################
# Allowed AMIs for EC2
###################################################

resource "aws_ec2_allowed_images_settings" "this" {
  count = var.ec2.allowed_amis.mode != "DISABLED" ? 1 : 0

  region = var.region

  state = local.ec2_allowed_amis_mode[var.ec2.allowed_amis.mode]

  dynamic "image_criterion" {
    for_each = var.ec2.allowed_amis.criteria
    iterator = criterion

    content {
      image_providers = (length(criterion.value.providers) > 0
        ? criterion.value.providers
        : null
      )
      image_names = (length(criterion.value.names) > 0
        ? criterion.value.names
        : null
      )
      marketplace_product_codes = (length(criterion.value.marketplace_product_codes) > 0
        ? criterion.value.marketplace_product_codes
        : null
      )

      dynamic "creation_date_condition" {
        for_each = criterion.value.maximum_days_since_created != null ? ["go"] : []

        content {
          maximum_days_since_created = criterion.value.maximum_days_since_created
        }
      }

      dynamic "deprecation_time_condition" {
        for_each = criterion.value.maximum_days_since_deprecated != null ? ["go"] : []

        content {
          maximum_days_since_deprecated = criterion.value.maximum_days_since_deprecated
        }
      }
    }
  }
}


###################################################
# Public Access Block for EC2 AMI
###################################################

resource "aws_ec2_image_block_public_access" "this" {
  region = var.region

  state = var.ec2.ami_public_access_mode
}


###################################################
# Default Credit Specification for EC2
###################################################

# INFO: Not supported attributes
# - `timeouts`
# INFO: The default credit specification for an instance family can be modified
# only once in a rolling 5-minute period, and up to four times in a rolling 24-hour period.
resource "aws_ec2_default_credit_specification" "this" {
  for_each = var.ec2.default_credit_specifications

  region = var.region

  instance_family = each.key
  cpu_credits     = each.value
}


###################################################
# Instance Metadata Defaults for EC2
###################################################

resource "aws_ec2_instance_metadata_defaults" "this" {
  count = anytrue([
    for k, v in var.ec2.instance_metadata_defaults :
    v != null
  ]) ? 1 : 0

  region = var.region

  http_endpoint = (var.ec2.instance_metadata_defaults.http_enabled != null
    ? (var.ec2.instance_metadata_defaults.http_enabled ? "enabled" : "disabled")
    : "no-preference"
  )
  http_tokens = (var.ec2.instance_metadata_defaults.http_token_required != null
    ? (var.ec2.instance_metadata_defaults.http_token_required ? "required" : "optional")
    : "no-preference"
  )
  http_put_response_hop_limit = coalesce(var.ec2.instance_metadata_defaults.http_put_response_hop_limit, -1)

  instance_metadata_tags = (var.ec2.instance_metadata_defaults.instance_tags_enabled != null
    ? (var.ec2.instance_metadata_defaults.instance_tags_enabled ? "enabled" : "disabled")
    : "no-preference"
  )
}


###################################################
# Serial Console Access for EC2
###################################################

resource "aws_ec2_serial_console_access" "this" {
  region = var.region

  enabled = var.ec2.serial_console_enabled
}
