variable "name" {
  description = "Desired name for the IAM group."
  type        = string
}

variable "path" {
  description = "Desired path for the IAM group."
  type        = string
  default     = "/"
}

variable "assumable_roles" {
  description = "List of IAM roles ARNs which can be assumed by the group."
  type        = list(string)
  default     = []
}

variable "policies" {
  description = "List of IAM policies ARNs to attach to IAM group."
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = "Map of inline IAM policies to attach to IAM group. (`name` => `policy`)."
  type        = map(string)
  default     = {}
}
