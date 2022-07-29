###################################################
# Availability Zone Group for VPC
###################################################

resource "aws_ec2_availability_zone_group" "this" {
  for_each = var.vpc_availability_zone_groups

  group_name = each.key
  opt_in_status = each.value ? "opted-in" : "not-opted-in"
}
