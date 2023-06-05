variable "account_id" {
  description = "(Required) The identifier of an AWS account which the assignment willb e created. Typically a 10-12 digit string."
  type        = string
  nullable    = false
}

variable "permission_set_arn" {
  description = "(Required) The ARN of the Permission Set that the admin wants to grant the principal access to."
  type        = string
  nullable    = false
}

variable "groups" {
  description = "(Optional) List of names of Group entities who can access to the Permission Set."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "users" {
  description = "(Optional) List of names of User entities who can access to the Permission Set."
  type        = list(string)
  default     = []
  nullable    = false
}
