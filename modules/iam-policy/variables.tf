variable "name" {
  description = "(Required) The name of the IAM policy."
  type        = string
  nullable    = false
}

variable "path" {
  description = "(Optional) The path in which to create the policy. Defaults to `/`."
  type        = string
  default     = "/"
  nullable    = false
}

variable "description" {
  description = "(Optional) The description of the IAM policy."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "policy" {
  description = "(Required) The policy document. This is a JSON formatted string."
  type        = string
  nullable    = false
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
