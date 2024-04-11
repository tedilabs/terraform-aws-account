variable "name" {
  description = "(Required) A friendly name for the member account."
  type        = string
  nullable    = false
}

variable "email" {
  description = "(Required) The email address of the owner to assign to the new member account. This email address must not already be associated with another AWS account."
  type        = string
  nullable    = false
}

variable "parent_id" {
  description = "(Optional) Parent Organizational Unit ID or Root ID for the account. Defaults to the Organization default Root ID. A configuration must be present for this argument to perform drift detection."
  type        = string
  default     = null
  nullable    = true
}

variable "iam_user_access_to_billing_allowed" {
  description = "(Optional) If true, the new account enables IAM users to access account billing information if they have the required permissions. If false, then only the root user of the new account can access account billing information."
  type        = bool
  default     = false
  nullable    = false
}

variable "preconfigured_administrator_role_name" {
  description = "(Optional) The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the master account, allowing users in the master account to assume the role, as permitted by the master account administrator. The role has administrator permissions in the new member account."
  type        = string
  default     = null
  nullable    = false
}

variable "delegated_services" {
  description = "(Optional) A list of service principals of the AWS service for which you want to make the member account a delegated administrator."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "policies" {
  description = "(Optional) List of IDs of the policies to be attached to the Account."
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
