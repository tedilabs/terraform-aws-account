variable "name" {
  description = "(Required) The name for the AWS account. Used for the account alias."
  type        = string
  nullable    = false
}

variable "password_policy" {
  description = "(Optional) Password Policy for the AWS account."
  type = object({
    minimum_password_length        = optional(number, 8)
    require_numbers                = optional(bool, true)
    require_symbols                = optional(bool, true)
    require_lowercase_characters   = optional(bool, true)
    require_uppercase_characters   = optional(bool, true)
    allow_users_to_change_password = optional(bool, true)
    hard_expiry                    = optional(bool, false)
    max_password_age               = optional(number, 0)
    password_reuse_prevention      = optional(number, 0)
  })
  default  = {}
  nullable = false
}

variable "additional_regions" {
  description = "(Optional) A map of additional regions to enable for the account. Each key should be a region name and the value should be `true` to enable the region or `false` to disable it. By default, all regions are disabled."
  type        = map(bool)
  default     = {}
  nullable    = false

  validation {
    condition = alltrue([
      for region in keys(var.additional_regions) :
      contains([
        "af-south-1",
        "ap-east-1",
        "ap-east-2",
        "ap-south-2",
        "ap-southeast-3",
        "ap-southeast-4",
        "ap-southeast-5",
        "ap-southeast-6",
        "ap-southeast-7",
        "ca-west-1",
        "eu-south-1",
        "eu-south-2",
        "eu-central-2",
        "me-south-1",
        "me-central-1",
        "mx-central-1",
        "il-central-1",
      ], region)
    ])
    error_message = "Available regions for `additional_regions` are `af-south-1`, `ap-east-1`, `ap-east-2`, `ap-south-2`, `ap-southeast-3`, `ap-southeast-4`, `ap-southeast-5`, `ap-southeast-6`, `ap-southeast-7`, `ca-west-1`, `eu-south-1`, `eu-south-2`, `eu-central-2`, `me-south-1`, `me-central-1`, `mx-central-1`, `il-central-1`."
  }
}

variable "primary_contact" {
  description = <<EOF
  (Optional) The configuration of the primary contact for the AWS Account. `primary_contact` as defined below.
    (Required) `name` - The full name of the primary contact address.
    (Optional) `company_name` - The name of the company associated with the primary contact information, if any.
    (Required) `country_code` - The ISO-3166 two-letter country code for the primary contact address.
    (Optional) `state` - The state or region of the primary contact address. This field is required in selected countries.
    (Required) `city` - The city of the primary contact address.
    (Optional) `district` - The district or county of the primary contact address, if any.
    (Required) `address_line_1` - The first line of the primary contact address.
    (Optional) `address_line_2` - The second line of the primary contact address, if any.
    (Optional) `address_line_3` - The third line of the primary contact address, if any.
    (Required) `postal_code` - The postal code of the primary contact address.
    (Required) `phone` - The phone number of the primary contact information. The number will be validated and, in some countries, checked for activation.
    (Optional) `website_url` -  The URL of the website associated with the primary contact information, if any.
  EOF
  type = object({
    name           = string
    company_name   = optional(string, "")
    country_code   = string
    state          = optional(string, "")
    city           = string
    district       = optional(string, "")
    address_line_1 = string
    address_line_2 = optional(string, "")
    address_line_3 = optional(string, "")
    postal_code    = string
    phone          = string
    website_url    = optional(string, "")
  })
  nullable = true
  default  = null
}

variable "billing_contact" {
  description = <<EOF
  (Optional) The configuration of the billing contact for the AWS Account. `billing_contact` as defined below.
    (Required) `name` - The name of the billing contact.
    (Optional) `title` - The tile of the billing contact. Defaults to `Billing Manager`.
    (Required) `email` - The email address of the billing contact.
    (Required) `phone` - The phone number of the billing contact.
  EOF
  type = object({
    name  = string
    title = optional(string, "Billing Manager")
    email = string
    phone = string
  })
  nullable = true
  default  = null
}

variable "operation_contact" {
  description = <<EOF
  (Optional) The configuration of the operation contact for the AWS Account. `operation_contact` as defined below.
    (Required) `name` - The name of the operation contact.
    (Optional) `title` - The tile of the operation contact. Defaults to `Operation Manager`.
    (Required) `email` - The email address of the operation contact.
    (Required) `phone` - The phone number of the operation contact.
  EOF
  type = object({
    name  = string
    title = optional(string, "Operation Manager")
    email = string
    phone = string
  })
  nullable = true
  default  = null
}

variable "security_contact" {
  description = <<EOF
  (Optional) The configuration of the security contact for the AWS Account. `security_contact` as defined below.
    (Required) `name` - The name of the security contact.
    (Optional) `title` - The tile of the security contact. Defaults to `Security Manager`.
    (Required) `email` - The email address of the security contact.
    (Required) `phone` - The phone number of the security contact.
  EOF
  type = object({
    name  = string
    title = optional(string, "Security Manager")
    email = string
    phone = string
  })
  nullable = true
  default  = null
}

variable "cost" {
  description = <<EOF
  (Optional) The configuration of the Cost & Billing for the AWS Account. `cost` as defined below.
    (Optional) `cost_allocation_tags` - A set of the key for the cost allocation tags.
  EOF
  type = object({
    cost_allocation_tags = optional(set(string), [])
  })
  default  = {}
  nullable = false
}

variable "cost_optimization_hub" {
  description = <<EOF
  (Optional) The configuration of the Cost Optimization Hub for the AWS Account. `cost_optimization_hub` as defined below.
    (Optional) `enabled` - Whether to enable Cost Optimization Hub for the AWS Account. Defaults to `true`.
    (Optional) `scope` - The scope of Cost Optimization Hub enrollment. Valid values are `ACCOUNT` and `ORGANIZATION`. Defaults to `ACCOUNT`.
    (Optional) `allow_member_account_discount_visibility` - Whether to allow member accounts to access estimated savings after discounts. Defaults to `false`.
    (Optional) `savings_estimation_mode` - The mode for savings estimation. Valid values are `BEFORE_DISCOUNTS` and `AFTER_DISCOUNTS`. Defaults to `BEFORE_DISCOUNTS`.
  EOF
  type = object({
    enabled                                  = optional(bool, true)
    scope                                    = optional(string, "ACCOUNT")
    allow_member_account_discount_visibility = optional(bool, false)
    savings_estimation_mode                  = optional(string, "BEFORE_DISCOUNTS")
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["ACCOUNT", "ORGANIZATION"], var.cost_optimization_hub.scope)
    error_message = "Valid values for `scope` are `ACCOUNT` and `ORGANIZATION`."
  }
  validation {
    condition     = contains(["BEFORE_DISCOUNTS", "AFTER_DISCOUNTS"], var.cost_optimization_hub.savings_estimation_mode)
    error_message = "Valid values for `savings_estimation_mode` are `BEFORE_DISCOUNTS` and `AFTER_DISCOUNTS`."
  }
}

variable "ec2_spot_datafeed_subscription" {
  description = <<EOF
  (Optional) The configuration of the Spot Data Feed Subscription. `ec2_spot_datafeed_subscription` as defined below.
    (Optional) `enabled` - Indicate whether to enable Spot Data Feed Subscription to S3 Bucket. Defaults to `false`.
    (Optional) `s3_bucket` - The configuration of the S3 bucket where AWS deliver the spot data feed. `s3_bucket` as defined below.
      (Required) `name` - The name of the S3 bucket where AWS deliver the spot data feed.
      (Optional) `key_prefix` - The path of directory inside S3 bucket to place spot pricing data.
  EOF
  type = object({
    enabled = optional(bool, false)
    s3_bucket = optional(object({
      name       = optional(string, "")
      key_prefix = optional(string, "")
    }))
  })
  default  = {}
  nullable = false
}

variable "sts_global_endpoint_token_version" {
  description = <<EOF
  (Optional) The version of the STS global endpoint token. Valid values are `v1` and
  `v2`. Defaults to `v1`.
    `v1` - Version 1 Tokens are valid only in AWS Regions that are available by default. These tokens do not work in manually enabled Regions, such as Asia Pacific (Hong Kong).
    `v2` - Version 2 tokens are valid in all Regions. However, version 2 tokens include more characters and might affect systems where you temporarily store tokens.
  EOF
  type        = string
  default     = "v1"
  nullable    = false

  validation {
    condition     = contains(["v1", "v2"], var.sts_global_endpoint_token_version)
    error_message = "Valid values for `sts_global_endpoint_token_version` are `v1` and `v2`."
  }
}

variable "support_app" {
  description = <<EOF
  (Optional) The configuration of the Support App for the AWS Account. `support_app` as defined below.
    (Optional) `account_alias` - An account alias associated with a customer's account.
    (Optional) `slack_workspaces` - A set of team ID for each Slack workspace, which uniquely identifies a workspace.
    (Optional) `slack_channel_configurations` - A list of configurations for each Slack channels. Each block of `slack_channel_configurations` as defined below.
      (Optional) `name` - The name of the Slack channel configuration.
      (Required) `workspace` - The team ID of the Slack workspace, which uniquely identifies a workspace.
      (Required) `channel` - The ID of the Slack channel.
      (Optional) `permission` - The permission of the default IAM role which created by this module. Valid values are `READ_ONLY` and `FULL_ACCESS`. Defaults to `FULL_ACCESS`.
      (Optional) `channel_role` - The ARN (Amazon Resource Name) of the IAM role associated with the Support App to post messages to the Slack channel. Only required to override default role which created with `permission`.
      (Optional) `notification_case_severity` - The severity level of the support case that a customer wants to get notified for. Valid values are `ALL`, `HIGH`, and `NONE`. Defaults to `ALL`.
      (Optional) `notification_on_add_correspondence_to_case` - Whether to notify when a correspondence is added to a case. Defaults to `true`.
      (Optional) `notification_on_create_or_reopen_case` - Whether to notify when a case is created or reopened. Defaults to `true`.
      (Optional) `notification_on_resolve_case` - Whether to notify when a case is resolved. Defaults to `true`.
  EOF
  type = object({
    account_alias    = optional(string)
    slack_workspaces = optional(set(string), [])
    slack_channel_configurations = optional(list(object({
      name      = optional(string)
      workspace = string
      channel   = string

      # permission   = optional(string, "FULL_ACCESS")
      channel_role = optional(string)

      notification_case_severity                 = optional(string, "ALL")
      notification_on_add_correspondence_to_case = optional(bool, true)
      notification_on_create_or_reopen_case      = optional(bool, true)
      notification_on_resolve_case               = optional(bool, true)
    })), [])
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for config in var.support_app.slack_channel_configurations :
      contains(["ALL", "HIGH", "NONE"], config.notification_case_severity)
    ])
    error_message = "Valid values for `notification_case_severity` are `ALL`, `HIGH`, and `NONE`."
  }
  # validation {
  #   condition = alltrue([
  #     for config in var.support_app.slack_channel_configurations :
  #     contains(["READ_ONLY", "FULL_ACCESS"], config.permission)
  #   ])
  #   error_message = "Valid values for `permission` are `READ_ONLY` and `FULL_ACCESS`."
  # }
}

variable "s3_public_access_enabled" {
  description = "(Optional) Whether to enable S3 account-level Public Access Block configuration. Block the public access to S3 bucket if the value is `false`."
  type        = bool
  default     = false
  nullable    = false
}
