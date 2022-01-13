variable "name" {
  description = "Desired name for the IAM role."
  type        = string
}

variable "path" {
  description = "Desired path for the IAM role."
  type        = string
  default     = "/"
}

variable "description" {
  description = "The description of the role."
  type        = string
  default     = ""
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200."
  type        = number
  default     = 3600
}

variable "force_detach_policies" {
  description = "Specifies to force detaching any policies the role has before destroying it."
  type        = bool
  default     = false
}

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
  type        = string
  default     = ""
}

variable "trusted_iam_entities" {
  description = "A list of ARNs of AWS IAM entities who can assume the role."
  type        = list(string)
  default     = []
}

variable "trusted_services" {
  description = "AWS Services that can assume the role."
  type        = list(string)
  default     = []
}

variable "trusted_oidc_providers" {
  description = "A list of OIDC identity providers. Supported types are `amazon`, `aws-cognito`, `aws-iam`, `facebook`, `google`. `type` is required. `url` is required only when `type` is `aws-iam`."
  type        = list(map(string))
  default     = []

  validation {
    condition = alltrue([
      for provider in var.trusted_oidc_providers :
      contains(["amazon", "aws-cognito", "aws-iam", "facebook", "google"], provider.type)
    ])
    error_message = "Type of provider must be either `amazon`, `aws-cognito`, `aws-iam`, `facebook`, or `google`."
  }
}

variable "trusted_saml_providers" {
  description = "A list of ARNs of SAML identity providers in AWS IAM."
  type        = list(string)
  default     = []
}

variable "trusted_oidc_conditions" {
  description = "Required conditions to assume the role for OIDC providers."
  type = list(object({
    key       = string
    condition = string
    values    = list(string)
  }))
  default = []
}

variable "trusted_saml_conditions" {
  description = "Required conditions to assume the role for SAML providers."
  type = list(object({
    key       = string
    condition = string
    values    = list(string)
  }))
  default = []
}

variable "conditions" {
  description = "Required conditions to assume the role."
  type = list(object({
    key       = string
    condition = string
    values    = list(string)
  }))
  default = []
}

variable "mfa_required" {
  description = "Whether MFA should be required to assume the role."
  type        = bool
  default     = false
}

variable "mfa_ttl" {
  description = "Max age of valid MFA (in seconds) for roles which require MFA."
  type        = number
  default     = 24 * 60 * 60
}

variable "effective_date" {
  description = "Allow to assume IAM role only after a specific date and time."
  type        = string
  default     = null

  validation {
    # Fail if the variable is not a valid timestamp
    condition     = var.effective_date == null || can(formatdate("", var.effective_date))
    error_message = "Require a valid RFC 3339 timestamp."
  }
}

variable "expiration_date" {
  description = "Allow to assume IAM role only before a specific date and time."
  type        = string
  default     = null

  validation {
    # Fail if the variable is not a valid timestamp
    condition     = var.expiration_date == null || can(formatdate("", var.expiration_date))
    error_message = "Require a valid RFC 3339 timestamp."
  }
}

variable "source_ip_whitelist" {
  description = "A list of source IP addresses or CIDRs allowed to assume IAM role from."
  type        = list(string)
  default     = []
}

variable "source_ip_blacklist" {
  description = "A list of source IP addresses or CIDRs denied to assume IAM role from."
  type        = list(string)
  default     = []
}

variable "assumable_roles" {
  description = "List of IAM roles ARNs which can be assumed by the role."
  type        = list(string)
  default     = []
}

variable "policies" {
  description = "List of IAM policies ARNs to attach to IAM role."
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = "Map of inline IAM policies to attach to IAM role. (`name` => `policy`)."
  type        = map(string)
  default     = {}
}

variable "instance_profile_enabled" {
  description = "Controls if Instance Profile should be created."
  type        = bool
  default     = false
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
