output "id" {
  description = "The AWS Account ID."
  value       = data.aws_caller_identity.this.account_id
}

output "name" {
  description = "Name of the AWS account. The account alias."
  value       = aws_iam_account_alias.this.account_alias
}

output "signin_url" {
  description = "The URL to signin for the AWS account."
  value       = "https://${var.name}.signin.aws.amazon.com/console"
}

output "password_policy" {
  description = "Password Policy for the AWS Account. `expire_passwords` indicates whether passwords in the account expire. Returns `true` if `max_password_age` contains a value greater than 0."
  value       = aws_iam_account_password_policy.this
}

output "billing_contact" {
  description = "The billing contact attached to an AWS Account."
  value = try({
    name  = aws_account_alternate_contact.billing[0].name
    title = aws_account_alternate_contact.billing[0].title
    email = aws_account_alternate_contact.billing[0].email_address
    phone = aws_account_alternate_contact.billing[0].phone_number
  }, null)
}

output "operation_contact" {
  description = "The operation contact attached to an AWS Account."
  value = try({
    name  = aws_account_alternate_contact.operation[0].name
    title = aws_account_alternate_contact.operation[0].title
    email = aws_account_alternate_contact.operation[0].email_address
    phone = aws_account_alternate_contact.operation[0].phone_number
  }, null)
}

output "security_contact" {
  description = "The security contact attached to an AWS Account."
  value = try({
    name  = aws_account_alternate_contact.security[0].name
    title = aws_account_alternate_contact.security[0].title
    email = aws_account_alternate_contact.security[0].email_address
    phone = aws_account_alternate_contact.security[0].phone_number
  }, null)
}

output "ec2" {
  description = <<EOF
  The account-level configurations of EC2 service.
    `spot_datafeed_subscription` - To help you understand the charges for your Spot instances, Amazon EC2 provides a data feed that describes your Spot instance usage and pricing. This data feed is sent to an Amazon S3 bucket that you specify when you subscribe to the data feed.
  EOF
  value = {
    spot_datafeed_subscription = {
      enabled = var.ec2_spot_datafeed_subscription_enabled
      s3 = {
        bucket = one(aws_spot_datafeed_subscription.this[*].bucket)
        prefix = one(aws_spot_datafeed_subscription.this[*].prefix)
      }
    }
  }
}

output "s3" {
  description = <<EOF
  The account-level configurations of S3 service.
    `public_access_enabled` - Whether to enable S3 account-level Public Access Block configuration.
  EOF
  value = {
    public_access_enabled = var.s3_public_access_enabled
  }
}
