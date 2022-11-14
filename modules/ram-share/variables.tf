variable "name" {
  description = "(Required) The name of the resource share."
  type        = string
}

variable "external_principals_allowed" {
  description = "(Optional) Indicates whether principals outside your organization can be associated with a resource share."
  type        = bool
  default     = false
  nullable    = false
}

variable "permissions" {
  description = "(Optional) A list of the names of the RAM permission to associate with the resource share. If you do not specify, RAM automatically attaches the default version of the permission for each resource type. You can associate only one permission with each resource type included in the resource share."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "principals" {
  description = "(Optional) A list of the Amazon Resource Names (ARNs) of the principal to associate with the RAM Resource Share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "resources" {
  description = "(Optional) A list of the Amazon Resource Names (ARNs) of the resource to associate with the RAM Resource Share."
  type        = list(string)
  default     = []
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
