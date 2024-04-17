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

output "additional_regions" {
  description = "A set of additional regions enabled in the account."
  value       = var.additional_regions
}

output "primary_contact" {
  description = "The primary contact attached to an AWS Account."
  value = try({
    name           = aws_account_primary_contact.this[0].full_name
    company_name   = aws_account_primary_contact.this[0].company_name
    country_code   = aws_account_primary_contact.this[0].country_code
    state          = aws_account_primary_contact.this[0].state_or_region
    city           = aws_account_primary_contact.this[0].city
    district       = aws_account_primary_contact.this[0].district_or_county
    address_line_1 = aws_account_primary_contact.this[0].address_line_1
    address_line_2 = aws_account_primary_contact.this[0].address_line_2
    address_line_3 = aws_account_primary_contact.this[0].address_line_3
    postal_code    = aws_account_primary_contact.this[0].postal_code
    phone          = aws_account_primary_contact.this[0].phone_number
    website_url    = aws_account_primary_contact.this[0].website_url
  }, null)
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
      enabled = var.ec2_spot_datafeed_subscription.enabled
      s3 = {
        bucket = one(aws_spot_datafeed_subscription.this[*].bucket)
        prefix = one(aws_spot_datafeed_subscription.this[*].prefix)
      }
    }
  }
}

output "sts" {
  description = <<EOF
  The account-level configurations of STS service.
    `global_endpoint_token_version` - The version of the STS global endpoint token.
  EOF
  value = {
    global_endpoint_token_version = {
      for k, v in local.global_endpoint_token_version :
      v => k
    }[aws_iam_security_token_service_preferences.this.global_endpoint_token_version]
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
