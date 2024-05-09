###################################################
# Public Access Block for EC2 AMI
###################################################

resource "aws_ec2_image_block_public_access" "this" {
  state = (var.ec2.ami_public_access_enabled
    ? "unblocked"
    : "block-new-sharing"
  )
}


###################################################
# Instance Metadata Defaults for EC2
###################################################

resource "aws_ec2_instance_metadata_defaults" "this" {
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
  enabled = var.ec2.serial_console_enabled
}
