# output "id" {
#   description = "The AWS Account ID."
#   value       = data.aws_caller_identity.this.account_id
# }
#
# output "name" {
#   description = "Name of the AWS account. The account alias."
#   value       = aws_iam_account_alias.this.account_alias
# }
#
output "allocation_tags" {
  description = "A set of activated Cost Allocation Tags."
  value = toset([
    for tag in aws_ce_cost_allocation_tag.this :
    tag.tag_key
  ])
}

output "anomaly_detection" {
  description = <<EOF
  The configuration for the cost anomaly detection.
    `monitors` - A list of cost anomaly detection monitors.
    `subscriptions` - A list of cost anomaly detection subscriptions.
  EOF
  value = {
    monitors = {
      for name, monitor in aws_ce_anomaly_monitor.this :
      name => {
        arn           = monitor.arn
        id            = monitor.id
        name          = monitor.name
        type          = monitor.monitor_type
        dimension     = monitor.monitor_dimension
        specification = monitor.monitor_specification
      }
    }
    # subscriptions = aws_ce_anomaly_subscription.this
  }
}

# output "password_policy" {
#   description = "Password Policy for the AWS Account. `expire_passwords` indicates whether passwords in the account expire. Returns `true` if `max_password_age` contains a value greater than 0."
#   value       = aws_iam_account_password_policy.this
# }
#
# output "billing_contact" {
#   description = "The billing contact attached to an AWS Account."
#   value = try({
#     name  = aws_account_alternate_contact.billing[0].name
#     title = aws_account_alternate_contact.billing[0].title
#     email = aws_account_alternate_contact.billing[0].email_address
#     phone = aws_account_alternate_contact.billing[0].phone_number
#   }, null)
# }
#
# output "operation_contact" {
#   description = "The operation contact attached to an AWS Account."
#   value = try({
#     name  = aws_account_alternate_contact.operation[0].name
#     title = aws_account_alternate_contact.operation[0].title
#     email = aws_account_alternate_contact.operation[0].email_address
#     phone = aws_account_alternate_contact.operation[0].phone_number
#   }, null)
# }
#
# output "security_contact" {
#   description = "The security contact attached to an AWS Account."
#   value = try({
#     name  = aws_account_alternate_contact.security[0].name
#     title = aws_account_alternate_contact.security[0].title
#     email = aws_account_alternate_contact.security[0].email_address
#     phone = aws_account_alternate_contact.security[0].phone_number
#   }, null)
# }
#
# output "ec2" {
#   description = <<EOF
#   The account-level configurations of EC2 service.
#     `spot_datafeed_subscription` - To help you understand the charges for your Spot instances, Amazon EC2 provides a data feed that describes your Spot instance usage and pricing. This data feed is sent to an Amazon S3 bucket that you specify when you subscribe to the data feed.
#   EOF
#   value = {
#     spot_datafeed_subscription = {
#       enabled = var.ec2_spot_datafeed_subscription_enabled
#       s3 = {
#         bucket = one(aws_spot_datafeed_subscription.this[*].bucket)
#         prefix = one(aws_spot_datafeed_subscription.this[*].prefix)
#       }
#     }
#   }
# }
#
output "zzz" {
  value = aws_ce_cost_allocation_tag.this
}
