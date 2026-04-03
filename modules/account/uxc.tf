###################################################
# UXC Account Customizations
###################################################

resource "aws_uxc_account_customizations" "this" {
  account_color    = var.uxc.account_color
  visible_regions  = var.uxc.visible_regions
  visible_services = var.uxc.visible_services
}
