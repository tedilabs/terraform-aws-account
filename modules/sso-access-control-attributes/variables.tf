variable "attributes" {
  description = "(Optional) A map of attributes for access control are used in permission policies that determine who in an identity source can access your AWS resources."
  type        = map(string)
  default     = {}
  nullable    = false
}
