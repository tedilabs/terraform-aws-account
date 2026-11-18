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
# Serial Consol Access for EC2
###################################################

resource "aws_ec2_serial_console_access" "this" {
  region = var.region

  enabled = var.ec2.serial_console_enabled
}
