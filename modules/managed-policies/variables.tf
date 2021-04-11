variable "enabled_policies" {
  description = "List of IAM policies to enable as map. `policy` is required. `name`, `path`, `description` are optional."
  type        = list(map(string))
  default     = []

  validation {
    condition = alltrue([
      for item in var.enabled_policies :
      contains(["self-service-access-key", "self-service-mfa", "self-service-password", "self-service-ssh-public-key"], item.policy)
    ])
    error_message = "Require supported policy."
  }
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
