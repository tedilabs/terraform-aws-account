variable "name" {
  description = "The name of the Organization."
  type        = string
}

variable "all_features_enabled" {
  description = "Whether to create AWS Organization with all features or only consolidated billing feature."
  type        = bool
  default     = true
}

variable "ai_services_opt_out_policy_type_enabled" {
  description = "Whether to enable AI services opt-out polices in the Organization."
  type        = bool
  default     = false
}

variable "backup_policy_type_enabled" {
  description = "Whether to enable Backup polices in the Organization."
  type        = bool
  default     = false
}

variable "service_control_policy_type_enabled" {
  description = "Whether to enable Service control polices(SCPs) in the Organization."
  type        = bool
  default     = true
}

variable "tag_policy_type_enabled" {
  description = "Whether to enable Tag polices in the Organization."
  type        = bool
  default     = false
}

variable "trusted_access_enabled_service_principals" {
  description = "List of AWS service principal names for which you want to enable integration with the organization. This is typically in the form of a URL, such as service-abbreviation.amazonaws.com. Organization must `all_featrues_enabled` set to true."
  type        = list(string)
  default     = []
}

variable "policies" {
  description = "List of IDs of the policies to be attached to the Organization."
  type        = list(string)
  default     = []
}

variable "module_tags_enabled" {
  description = "Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
}
