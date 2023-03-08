variable "name" {
  description = "Desired name for the IAM role."
  type        = string
}

variable "path" {
  description = "Desired path for the IAM role."
  type        = string
  default     = "/"
  nullable    = false
}

variable "description" {
  description = "The description of the role."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200."
  type        = number
  default     = 3600
  nullable    = false
}

variable "force_detach_policies" {
  description = "Specifies to force detaching any policies the role has before destroying it."
  type        = bool
  default     = false
  nullable    = false
}

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
  type        = string
  default     = null
}

variable "trusted_session_tagging" {
  description = <<EOF
  (Optional) A configurations of session tags in AWS STS. `trusted_session_tagging` block as defined below.
    (Optional) `enabled` - Indicate whether you want to enable session tagging. Defaults to `true`.
    (Optional) `allowed_tags` - A map of tag key/values pairs to limit the tag keys and values that can be used as session tags.
    (Optional) `allowed_transitive_tag_keys` - A set of tag keys to limit the maximum set of transitive tags.
  EOF
  type = object({
    enabled                     = optional(bool, true)
    allowed_tags                = optional(map(set(string)), {})
    allowed_transitive_tag_keys = optional(set(string), [])
  })
  default  = {}
  nullable = false
}

variable "trusted_iam_entities" {
  description = "A list of ARNs of AWS IAM entities who can assume the role."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "trusted_services" {
  description = "AWS Services that can assume the role."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "trusted_oidc_providers" {
  description = <<EOF
  (Optional) A list of configurations of OIDC identity providers. Each value of `trusted_oidc_providers` as defined below.
    (Required) `url` - The URL of the OIDC identity provider. If the provider is not common, the corresponding IAM OIDC Provider should be created before. Supported common OIDC providers are `accounts.google.com`, `cognito-identity.amazonaws.com`, `graph.facebook.com`, `www.amazon.com`.
    (Optional) `conditions` - A list of required conditions to assume the role via OIDC providers.
      (Required) `key` - The OIDC key to match a condition for when a policy is in effect.
      (Required) `condition` - The condition operator to match the condition keys and values in the policy against keys and values in the request context. Examples: `StringEquals`, `StringLike`.
      (Optional) `values` - A list of allowed values of OIDC key to match a condition with condition operator.
  EOF
  type = list(object({
    url = string
    conditions = optional(list(object({
      key       = string
      condition = string
      values    = list(string)
    })), [])
  }))
  default  = []
  nullable = false
}

variable "trusted_saml_providers" {
  description = <<EOF
  (Optional) A list of configurations of SAML identity providers. Each value of `trusted_saml_providers` as defined below.
    (Required) `name` - The name of the SAML identity provider.
    (Optional) `conditions` - A list of required conditions to assume the role via SAML providers.
      (Required) `key` - The SAML key to match a condition for when a policy is in effect.
      (Required) `condition` - The condition operator to match the condition keys and values in the policy against keys and values in the request context. Examples: `StringEquals`, `StringLike`.
      (Optional) `values` - A list of allowed values of SAML key to match a condition with condition operator.
  EOF
  type = list(object({
    name = string
    conditions = optional(list(object({
      key       = string
      condition = string
      values    = list(string)
    })), [])
  }))
  default  = []
  nullable = false
}

variable "conditions" {
  description = "Required conditions to assume the role."
  type = list(object({
    key       = string
    condition = string
    values    = list(string)
  }))
  default  = []
  nullable = false
}

variable "mfa_required" {
  description = "Whether MFA should be required to assume the role."
  type        = bool
  default     = false
  nullable    = false
}

variable "mfa_ttl" {
  description = "Max age of valid MFA (in seconds) for roles which require MFA."
  type        = number
  default     = 24 * 60 * 60
  nullable    = false
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
  nullable    = false
}

variable "source_ip_blacklist" {
  description = "A list of source IP addresses or CIDRs denied to assume IAM role from."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "assumable_roles" {
  description = "List of IAM roles ARNs which can be assumed by the role."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "policies" {
  description = "List of IAM policies ARNs to attach to IAM role."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "inline_policies" {
  description = "Map of inline IAM policies to attach to IAM role. (`name` => `policy`)."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "instance_profile_enabled" {
  description = "Controls if Instance Profile should be created."
  type        = bool
  default     = false
  nullable    = false
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
  nullable    = false
}

variable "resource_group_name" {
  description = "The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}
