###################################################
# Serial Consol Access for EC2
###################################################

resource "aws_ec2_serial_console_access" "this" {
  enabled = var.ec2_serial_console_enabled
}
