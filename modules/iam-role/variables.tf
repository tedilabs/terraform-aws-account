variable "name" {
  description = "(Required) Desired name for the IAM role."
  type        = string
  nullable    = false
}

variable "path" {
  description = "(Optional) Desired path for the IAM role."
  type        = string
  default     = "/"
  nullable    = false
}

variable "description" {
  description = "(Optional) The description of the role."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "max_session_duration" {
  description = "(Optional) Maximum session duration (in seconds) that you want to set for the specified role. Valid value is from 1 hour (`3600`) to 12 hours (`43200`). Defaults to `3600`."
  type        = number
  default     = 3600
  nullable    = false
}

variable "force_detach_policies" {
  description = "(Optional) Specifies to force detaching any policies the role has before destroying it. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "permissions_boundary" {
  description = "(Optional) The ARN of the policy that is used to set the permissions boundary for the role."
  type        = string
  default     = null
  nullable    = true
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

variable "trusted_source_identity" {
  description = <<EOF
  (Optional) A configurations of source identity in AWS STS. `trusted_source_identity` block as defined below.
    (Optional) `enabled` - Indicate whether you want to enable source identity configuration. Defaults to `true`.
    (Optional) `allowed_identities` - A set of identities to limit the maximum set of source identities.
  EOF
  type = object({
    enabled            = optional(bool, true)
    allowed_identities = optional(set(string), [])
  })
  default  = {}
  nullable = false
}

variable "trusted_iam_entity_policies" {
  description = <<EOF
  (Optional) A configuration for trusted iam entity policies. Each item of `trusted_iam_entity_policies` is defined below.
    (Required) `iam_entities` - A list of ARNs of AWS IAM entities who can assume the role.
    (Optional) `conditions` - A list of required conditions to assume the role via IAM entities.
      (Required) `key` - The key to match a condition for when a policy is in effect.
      (Required) `condition` - The condition operator to match the condition keys and values in the policy against keys and values in the request context. Examples: `StringEquals`, `StringLike`.
      (Required) `values` - A list of allowed values of the key to match a condition with condition operator.
    (Optional) `mfa` - A configuration of MFA requirement.
      (Optional) `required` - Whether to require MFA to assume role. Defaults to `false`.
      (Optional) `ttl` - Max age of valid MFA (in seconds) for roles which require MFA. Defaults to `86400` (24 hours).
    (Optional) `effective_date` - Allow to assume IAM role only after a specific date and time.
    (Optional) `expiration_date` - Allow to assume IAM role only before a specific date and time.
    (Optional) `source_ip_whitelist` - A list of source IP addresses or CIDRs allowed to assume IAM role from.
    (Optional) `source_ip_blacklist` - A list of source IP addresses or CIDRs not allowed to assume IAM role from.
  EOF

  type = list(object({
    iam_entities = list(string)
    conditions = optional(list(object({
      key       = string
      condition = string
      values    = list(string)
    })), [])
    mfa = optional(object({
      required = optional(bool, false)
      ttl      = optional(number, 24 * 60 * 60)
    }), {})
    effective_date      = optional(string)
    expiration_date     = optional(string)
    source_ip_whitelist = optional(list(string), [])
    source_ip_blacklist = optional(list(string), [])
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for policy in var.trusted_iam_entity_policies :
      can(formatdate("", policy.effective_date))
      if policy.effective_date != null
    ])
    error_message = "`effective_date` should be a valid RFC 3339 timestamp."
  }
  validation {
    condition = alltrue([
      for policy in var.trusted_iam_entity_policies :
      can(formatdate("", policy.expiration_date))
      if policy.expiration_date != null
    ])
    error_message = "`expiration_date` should be a valid RFC 3339 timestamp."
  }
}

variable "trusted_service_policies" {
  description = <<EOF
  (Optional) A configuration for trusted service policies. Each item of `trusted_service_policies` is defined below.
    (Required) `services` - A list of AWS services that can assume the role.
    (Optional) `conditions` - A list of required conditions to assume the role via AWS services.
      (Required) `key` - The key to match a condition for when a policy is in effect.
      (Required) `condition` - The condition operator to match the condition keys and values in the policy against keys and values in the request context. Examples: `StringEquals`, `StringLike`.
      (Required) `values` - A list of allowed values of the key to match a condition with condition operator.
    (Optional) `effective_date` - Allow to assume IAM role only after a specific date and time.
    (Optional) `expiration_date` - Allow to assume IAM role only before a specific date and time.
    (Optional) `source_ip_whitelist` - A list of source IP addresses or CIDRs allowed to assume IAM role from.
    (Optional) `source_ip_blacklist` - A list of source IP addresses or CIDRs not allowed to assume IAM role from.
  EOF

  type = list(object({
    services = list(string)
    conditions = optional(list(object({
      key       = string
      condition = string
      values    = list(string)
    })), [])
    effective_date      = optional(string)
    expiration_date     = optional(string)
    source_ip_whitelist = optional(list(string), [])
    source_ip_blacklist = optional(list(string), [])
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for policy in var.trusted_service_policies :
      can(formatdate("", policy.effective_date))
      if policy.effective_date != null
    ])
    error_message = "`effective_date` should be a valid RFC 3339 timestamp."
  }
  validation {
    condition = alltrue([
      for policy in var.trusted_service_policies :
      can(formatdate("", policy.expiration_date))
      if policy.expiration_date != null
    ])
    error_message = "`expiration_date` should be a valid RFC 3339 timestamp."
  }
}

variable "trusted_oidc_provider_policies" {
  description = <<EOF
  (Optional) A configuration for trusted OIDC identity provider policies. Each item of `trusted_oidc_provider_policies` is defined below.
    (Required) `url` - The URL of the OIDC identity provider. If the provider is not common, the corresponding IAM OIDC Provider should be created before. Supported common OIDC providers are `accounts.google.com`, `cognito-identity.amazonaws.com`, `graph.facebook.com`, `www.amazon.com`.
    (Optional) `conditions` - A list of required conditions to assume the role via OIDC providers.
      (Required) `key` - The OIDC key to match a condition for when a policy is in effect.
      (Required) `condition` - The condition operator to match the condition keys and values in the policy against keys and values in the request context. Examples: `StringEquals`, `StringLike`.
      (Required) `values` - A list of allowed values of OIDC key to match a condition with condition operator.
    (Optional) `effective_date` - Allow to assume IAM role only after a specific date and time.
    (Optional) `expiration_date` - Allow to assume IAM role only before a specific date and time.
    (Optional) `source_ip_whitelist` - A list of source IP addresses or CIDRs allowed to assume IAM role from.
    (Optional) `source_ip_blacklist` - A list of source IP addresses or CIDRs not allowed to assume IAM role from.
  EOF

  type = list(object({
    url = string
    conditions = optional(list(object({
      key       = string
      condition = string
      values    = list(string)
    })), [])
    effective_date      = optional(string)
    expiration_date     = optional(string)
    source_ip_whitelist = optional(list(string), [])
    source_ip_blacklist = optional(list(string), [])
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for policy in var.trusted_oidc_provider_policies :
      can(formatdate("", policy.effective_date))
      if policy.effective_date != null
    ])
    error_message = "`effective_date` should be a valid RFC 3339 timestamp."
  }
  validation {
    condition = alltrue([
      for policy in var.trusted_oidc_provider_policies :
      can(formatdate("", policy.expiration_date))
      if policy.expiration_date != null
    ])
    error_message = "`expiration_date` should be a valid RFC 3339 timestamp."
  }
}

variable "trusted_saml_provider_policies" {
  description = <<EOF
  (Optional) A configuration for trusted SAML identity provider policies. Each item of `trusted_saml_provider_policies` is defined below.
    (Required) `name` - The name of the SAML identity provider.
    (Optional) `conditions` - A list of required conditions to assume the role via SAML providers.
      (Required) `key` - The SAML key to match a condition for when a policy is in effect.
      (Required) `condition` - The condition operator to match the condition keys and values in the policy against keys and values in the request context. Examples: `StringEquals`, `StringLike`.
      (Required) `values` - A list of allowed values of SAML key to match a condition with condition operator.
    (Optional) `effective_date` - Allow to assume IAM role only after a specific date and time.
    (Optional) `expiration_date` - Allow to assume IAM role only before a specific date and time.
    (Optional) `source_ip_whitelist` - A list of source IP addresses or CIDRs allowed to assume IAM role from.
    (Optional) `source_ip_blacklist` - A list of source IP addresses or CIDRs not allowed to assume IAM role from.
  EOF

  type = list(object({
    name = string
    conditions = optional(list(object({
      key       = string
      condition = string
      values    = list(string)
    })), [])
    effective_date      = optional(string)
    expiration_date     = optional(string)
    source_ip_whitelist = optional(list(string), [])
    source_ip_blacklist = optional(list(string), [])
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for policy in var.trusted_saml_provider_policies :
      can(formatdate("", policy.effective_date))
      if policy.effective_date != null
    ])
    error_message = "`effective_date` should be a valid RFC 3339 timestamp."
  }
  validation {
    condition = alltrue([
      for policy in var.trusted_saml_provider_policies :
      can(formatdate("", policy.expiration_date))
      if policy.expiration_date != null
    ])
    error_message = "`expiration_date` should be a valid RFC 3339 timestamp."
  }
}

variable "conditions" {
  description = <<EOF
  (Required) A list of required conditions to assume the role. Each item of `conditions` is defined below.
    (Required) `key` - The key to match a condition for when a policy is in effect.
    (Required) `condition` - The condition operator to match the condition keys and values in the policy against keys and values in the request context. Examples: `StringEquals`, `StringLike`.
    (Required) `values` - A list of allowed values of the key to match a condition with condition operator.
  EOF
  type = list(object({
    key       = string
    condition = string
    values    = list(string)
  }))
  default  = []
  nullable = false
}

variable "assumable_roles" {
  description = "(Optional) List of IAM roles ARNs which can be assumed by the role."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "policies" {
  description = "(Optional) List of IAM policies ARNs to attach to IAM role."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "inline_policies" {
  description = "(Optional) Map of inline IAM policies to attach to IAM role. (`name` => `policy`)."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "instance_profile" {
  description = <<EOF
  (Optional) A configuration for instance profile. `instance_profile` is defined below.
    (Optional) `enabled` - Whether to create instance profile. Defaults to `false`.
    (Optional) `name` - The name of the instance profile. If omitted, Terraform will assign a ame name with the role.
    (Optional) `path` - The path to the instance profile. Defaults to `/`.
    (Optional) `tags` - A map of tags to add to the instance profile.
  EOF
  type = object({
    enabled = optional(bool, false)
    name    = optional(string)
    path    = optional(string, "/")
    tags    = optional(map(string), {})
  })
  default  = {}
  nullable = false
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
  description = "(Optional) The name of Resource Groupolicy. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Groupolicy."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}
