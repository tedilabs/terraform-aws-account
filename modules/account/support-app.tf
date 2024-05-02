###################################################
# Account Alias for Support App
###################################################

resource "awscc_supportapp_account_alias" "this" {
  count = var.support_app.account_alias != null ? 1 : 0

  account_alias = var.support_app.account_alias
}


###################################################
# Slack Workspace Authorization for Support App
###################################################

# INFO: Not supported attributes
# - `version_id`
resource "awscc_supportapp_slack_workspace_configuration" "this" {
  for_each = var.support_app.slack_workspaces

  team_id = each.value
}


###################################################
# Slack Workspace Authorization for Support App
###################################################

resource "awscc_supportapp_slack_channel_configuration" "this" {
  for_each = {
    for configuration in var.support_app.slack_channel_configurations :
    configuration.name => configuration
  }

  channel_name = each.key
  team_id      = awscc_supportapp_slack_workspace_configuration.this[each.value.workspace].team_id
  channel_id   = each.value.channel


  ## Permissions
  # TODO: Use default role with `permission` variable
  channel_role_arn = each.value.channel_role


  ## Notification
  notify_on_case_severity              = lower(each.value.notification_case_severity)
  notify_on_add_correspondence_to_case = each.value.notification_on_add_correspondence_to_case
  notify_on_create_or_reopen_case      = each.value.notification_on_create_or_reopen_case
  notify_on_resolve_case               = each.value.notification_on_resolve_case
}
