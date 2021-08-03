variable "account_id" {
  description = "The identifier of an AWS account which the assignment willb e created. Typically a 10-12 digit string."
  type        = string
}

variable "permission_set_arn" {
  description = "The ARN of the Permission Set that the admin wants to grant the principal access to."
  type        = string
}

variable "groups" {
  description = "List of names of Group entities who can access to the Permission Set."
  type        = list(string)
  default     = []
}

variable "users" {
  description = "List of names of User entities who can access to the Permission Set."
  type        = list(string)
  default     = []
}
