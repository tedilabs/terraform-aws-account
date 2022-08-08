variable "name" {
  description = "(Required) The name of the Permission Set."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) The description of the Permission Set."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "session_duration" {
  description = "(Optional) The length of time that the application user sessions are valid in seconds. Duration should be a number between `3600` (1 hour) and `43200` (12 hours)."
  type        = number
  default     = 3600
  nullable    = false

  validation {
    condition = alltrue([
      var.session_duration >= 3600,
      var.session_duration <= 43200
    ])
    error_message = "The value of session duration should be a number between 3600 (1 hour) and 43200 (12 hours)."
  }
}

variable "relay_state" {
  description = "(Optional) The relay state URL used to redirect users within the application during the federation authentication process."
  type        = string
  default     = null
}

variable "managed_policies" {
  description = "(Optional) List of ARNs of IAM managed policies to be attached to the Permission Set."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "inline_policy" {
  description = "(Optional) The IAM inline policy to attach to a Permission Set. Only supports one IAM inline policy per Permission Set. Creating or updating this resource will automatically Provision the Permission Set to apply the corresponding updates to all assigned accounts."
  type        = string
  default     = null
}

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
