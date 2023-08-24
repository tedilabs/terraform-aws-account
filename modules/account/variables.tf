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
    company_name   = optional(string)
    country_code   = string
    state          = optional(string)
    city           = string
    district       = optional(string)
    address_line_1 = string
    address_line_2 = optional(string)
    address_line_3 = optional(string)
    postal_code    = string
    phone          = string
    website_url    = optional(string)
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

variable "s3_public_access_enabled" {
  description = "(Optional) Whether to enable S3 account-level Public Access Block configuration. Block the public access to S3 bucket if the value is `false`."
  type        = bool
  default     = false
  nullable    = false
}
