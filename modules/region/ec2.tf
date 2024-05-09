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
# Serial Consol Access for EC2
###################################################

resource "aws_ec2_serial_console_access" "this" {
  enabled = var.ec2.serial_console_enabled
}
