variable "name" {
  description = "A friendly name for the member account."
  type        = string
}

variable "email" {
  description = "The email address of the owner to assign to the new member account. This email address must not already be associated with another AWS account."
  type        = string
}

variable "parent_id" {
  description = "Parent Organizational Unit ID or Root ID for the account. Defaults to the Organization default Root ID. A configuration must be present for this argument to perform drift detection."
  type        = string
  default     = null
}

variable "iam_user_access_to_billing_allowed" {
  description = "If true, the new account enables IAM users to access account billing information if they have the required permissions. If false, then only the root user of the new account can access account billing information."
  type        = bool
  default     = false
}

variable "preconfigured_adminitrator_role_name" {
  description = "The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the master account, allowing users in the master account to assume the role, as permitted by the master account administrator. The role has administrator permissions in the new member account."
  type        = string
  default     = null
}

variable "delegated_services" {
  description = "A list of service principals of the AWS service for which you want to make the member account a delegated administrator."
  type        = set(string)
  default     = []
}

variable "policies" {
  description = "List of IDs of the policies to be attached to the Account."
  type        = list(string)
  default     = []
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
