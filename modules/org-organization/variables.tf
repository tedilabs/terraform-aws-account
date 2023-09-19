variable "name" {
  description = "(Required) The name of the Organization."
  type        = string
  nullable    = false
}

variable "all_features_enabled" {
  description = "(Optional) Whether to create AWS Organization with all features or only consolidated billing feature."
  type        = bool
  default     = true
  nullable    = false
}

variable "ai_services_opt_out_policy_type_enabled" {
  description = "(Optional) Whether to enable AI services opt-out polices in the Organization."
  type        = bool
  default     = false
  nullable    = false
}

variable "backup_policy_type_enabled" {
  description = "(Optional) Whether to enable Backup polices in the Organization."
  type        = bool
  default     = false
  nullable    = false
}

variable "service_control_policy_type_enabled" {
  description = "(Optional) Whether to enable Service control polices(SCPs) in the Organization."
  type        = bool
  default     = true
  nullable    = false
}

variable "tag_policy_type_enabled" {
  description = "(Optional) Whether to enable Tag polices in the Organization."
  type        = bool
  default     = false
  nullable    = false
}

variable "trusted_access_enabled_service_principals" {
  description = "(Optional) List of AWS service principal names for which you want to enable integration with the organization. This is typically in the form of a URL, such as service-abbreviation.amazonaws.com. Organization must `all_featrues_enabled` set to true."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "policies" {
  description = "(Optional) List of IDs of the policies to be attached to the Organization."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}
