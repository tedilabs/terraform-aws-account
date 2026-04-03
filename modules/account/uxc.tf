###################################################
# UXC Account Customizations
###################################################

resource "aws_uxc_account_customizations" "this" {
  account_color = var.uxc.account_color
  visible_regions = (length(var.uxc.visible_regions) > 0
    ? var.uxc.visible_regions
    : null
  )
  visible_services = (length(var.uxc.visible_services) > 0
    ? var.uxc.visible_services
    : null
  )
}
