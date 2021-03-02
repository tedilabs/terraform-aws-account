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

variable "trusted_saml_providers" {
  description = "A list of ARNs of SAML identity providers in AWS IAM."
  type        = list(string)
  default     = []
}

variable "trusted_saml_endpoint" {
  description = "AWS Services that can assume the role."
  type        = string
  default     = "https://signin.aws.amazon.com/saml"
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
