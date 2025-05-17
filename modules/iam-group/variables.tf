variable "name" {
  description = "(Required) Desired name for the IAM group."
  type        = string
  nullable    = false
}

variable "path" {
  description = "(Optional) Desired path for the IAM group. Defaults to `/`."
  type        = string
  default     = "/"
  nullable    = false
}

variable "assumable_roles" {
  description = "(Optional) A set of IAM roles ARNs which can be assumed by the group."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "exclusive_policy_management_enabled" {
  description = "(Optional) Whether to enable exclusive management for managed IAM policies of the IAM group. This includes removal of managed IAM policies which are not explicitly configured. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "exclusive_inline_policy_management_enabled" {
  description = "(Optional) Whether to enable exclusive management for inline IAM policies of the IAM user. This includes removal of inline IAM policies which are not explicitly configured. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "policies" {
  description = "(Optional) A set of IAM policies ARNs to attach to IAM group."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "inline_policies" {
  description = "(Optional) A map of inline IAM policies to attach to IAM group. The policy is a JSON document that you attach to an identity to specify what API actions you're allowing or denying for that identity, and under which conditions. Each key is the name of the policy, and the value is the policy document."
  type        = map(string)
  default     = {}
  nullable    = false
}

