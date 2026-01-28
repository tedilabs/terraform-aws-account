###################################################
# Notification Hubs for User Notifications (Account-level)
###################################################

resource "aws_notifications_notification_hub" "this" {
  for_each = var.user_notifications.notification_hubs

  notification_hub_region = each.value
}
