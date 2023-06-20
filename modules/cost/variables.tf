# variable "name" {
#   description = "(Required) The name for the AWS account. Used for the account alias."
#   type        = string
#   nullable    = false
# }
#
variable "allocation_tags" {
  description = "(Optional) A set of Cost Allocation Tags to activate."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "anomaly_detection_monitors" {
  description = <<EOF
  (Optional) A list of cost anomaly detection monitors to create.The provider of SSL certificate for the distribution. Valid values are `CLOUDFRONT`, `ACM` or `IAM`. Defaults to `CLOUDFRONT`. Each value of `anomaly_detection_monitors` as defined below.
    (Required) `name` - The name of the monitor.
    (Optional) `type` - The type of the monitor. Valid values are `CUSTOM` and `DIMENSIONAL`. Defaults to `CUSTOM`.
    (Optional) `dimension` - The dimension of the monitor to evaluate. Valid values are `SERVICE`. Defaults to `SERVICE`. Only required if monitor type is `DIMENSIONAL`.
    (Optional) `specification - The specification for custom-type monitor. A valid JSON representation for the Expression object. Only required if monitor type is `CUSTOM`.
  EOF
  type = list(object({
    name          = string
    type          = optional(string, "CUSTOM")
    dimension     = optional(string, "SERVICE")
    specification = optional(string, "")
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for monitor in var.anomaly_detection_monitors :
      contains(["CUSTOM", "DIMENSIONAL"], monitor.type)
    ])
    error_message = "Valid values for `type` are `CUSTOM` and `DIMENSIONAL`."
  }
  validation {
    condition = alltrue([
      for monitor in var.anomaly_detection_monitors :
      contains(["SERVICE"], monitor.dimension)
    ])
    error_message = "Valid values for `dimension` are `SERIVCE`."
  }
}
# variable "password_policy" {
#   description = "(Optional) Password Policy for the AWS account."
#   type = object({
#     minimum_password_length        = number
#     require_numbers                = bool
#     require_symbols                = bool
#     require_lowercase_characters   = bool
#     require_uppercase_characters   = bool
#     allow_users_to_change_password = bool
#     hard_expiry                    = bool
#     max_password_age               = number
#     password_reuse_prevention      = number
#   })
#   default = {
#     minimum_password_length        = 8
#     require_numbers                = true
#     require_symbols                = true
#     require_lowercase_characters   = true
#     require_uppercase_characters   = true
#     allow_users_to_change_password = true
#     hard_expiry                    = false
#     max_password_age               = 0
#     password_reuse_prevention      = 0
#   }
#   nullable = false
# }
#
# variable "ec2_spot_datafeed_subscription_enabled" {
#   description = "(Optional) Indicates whether to enable Spot Data Feed Subscription to S3 Bucket. Defaults to `false`."
#   type        = bool
#   default     = false
#   nullable    = false
# }
#
# variable "ec2_spot_datafeed_subscription_s3_bucket" {
#   description = "(Optional) The name of the S3 bucket to deliver Spot Data Feed to."
#   type        = string
#   default     = ""
#   nullable    = false
# }
#
# variable "ec2_spot_datafeed_subscription_s3_prefix" {
#   description = "(Optional) The path of directory inside S3 bucket to place spot pricing data."
#   type        = string
#   default     = ""
#   nullable    = false
# }

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "(Optional) Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
  nullable    = false
}

variable "resource_group_name" {
  description = "(Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}
