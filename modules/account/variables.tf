variable "name" {
  description = "(Required) The name for the AWS account. Used for the account alias."
  type        = string
  nullable    = false
}

variable "password_policy" {
  description = "(Optional) Password Policy for the AWS account."
  type = object({
    minimum_password_length        = number
    require_numbers                = bool
    require_symbols                = bool
    require_lowercase_characters   = bool
    require_uppercase_characters   = bool
    allow_users_to_change_password = bool
    hard_expiry                    = bool
    max_password_age               = number
    password_reuse_prevention      = number
  })
  default = {
    minimum_password_length        = 8
    require_numbers                = true
    require_symbols                = true
    require_lowercase_characters   = true
    require_uppercase_characters   = true
    allow_users_to_change_password = true
    hard_expiry                    = false
    max_password_age               = 0
    password_reuse_prevention      = 0
  }
  nullable = false
}

variable "billing_contact" {
  description = "(Optional) Billing Contact for the AWS Account."
  type        = map(string)
  default     = null
}

variable "operation_contact" {
  description = "(Optional) Operation Contact for the AWS Account."
  type        = map(string)
  default     = null
}

variable "security_contact" {
  description = "(Optional) Security Contact for the AWS Account."
  type        = map(string)
  default     = null
}

variable "ec2_spot_datafeed_subscription_enabled" {
  description = "(Optional) Indicates whether to enable Spot Data Feed Subscription to S3 Bucket. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "ec2_spot_datafeed_subscription_s3_bucket" {
  description = "(Optional) The name of the S3 bucket to deliver Spot Data Feed to."
  type        = string
  default     = ""
  nullable    = false
}

variable "ec2_spot_datafeed_subscription_s3_prefix" {
  description = "(Optional) The path of directory inside S3 bucket to place spot pricing data."
  type        = string
  default     = ""
  nullable    = false
}

variable "s3_public_access_enabled" {
  description = "(Optional) Whether to enable S3 account-level Public Access Block configuration. Block the public access to S3 bucket if the value is `false`."
  type        = bool
  default     = false
  nullable    = false
}
