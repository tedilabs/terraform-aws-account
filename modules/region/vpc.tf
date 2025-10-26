locals {
  block_public_access_mode = {
    "BIDIRECTIONAL" = "block-bidirectional"
    "INGRESS"       = "block-ingress"
    "OFF"           = "off"
  }
}


###################################################
# Availability Zone Group for VPC
###################################################

resource "aws_ec2_availability_zone_group" "this" {
  for_each = var.vpc.availability_zone_groups

  region = var.region

  group_name    = each.key
  opt_in_status = each.value ? "opted-in" : "not-opted-in"
}


###################################################
# Block Public Access for VPC
###################################################

resource "aws_vpc_block_public_access_options" "this" {
  count = var.vpc.block_public_access_mode != "OFF" ? 1 : 0

  region = var.region

  internet_gateway_block_mode = local.block_public_access_mode[var.vpc.block_public_access_mode]
}
