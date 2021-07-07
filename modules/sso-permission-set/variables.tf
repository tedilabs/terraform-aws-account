variable "name" {
  description = "The name of the Permission Set."
  type        = string
}

variable "description" {
  description = "The description of the Permission Set."
  type        = string
  default     = "Managed by Terraform."
}

variable "session_duration" {
  description = "The length of time that the application user sessions are valid in the ISO-8601 standard."
  type        = string
  default     = "PT1H"
}

variable "relay_state" {
  description = "The relay state URL used to redirect users within the application during the federation authentication process."
  type        = string
  default     = null
}

variable "managed_policies" {
  description = "List of ARNs of IAM managed policies to be attached to the Permission Set."
  type        = list(string)
  default     = []
}

variable "inline_policy" {
  description = "The IAM inline policy to attach to a Permission Set. Only supports one IAM inline policy per Permission Set. Creating or updating this resource will automatically Provision the Permission Set to apply the corresponding updates to all assigned accounts."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "module_tags_enabled" {
  description = "Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
}

variable "resource_group_description" {
  description = "The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
}
