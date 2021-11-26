variable "name" {
  description = "The name for the AWS account. Used for the account alias."
  type        = string
}

variable "password_policy" {
  description = "Password Policy for the AWS account."
  type = object({
    minimum_password_length        = number
    require_numbers                = bool
    require_symbols                = bool
    require_lowercase_characters   = bool
    require_uppercase_characters   = bool
    allow_users_to_change_password = bool
    hard_expiry                    = bool
    max_password_age               = number
    password_reuse_prevention      = number
  })
  default = {
    minimum_password_length        = 8
    require_numbers                = true
    require_symbols                = true
    require_lowercase_characters   = true
    require_uppercase_characters   = true
    allow_users_to_change_password = true
    hard_expiry                    = false
    max_password_age               = 0
    password_reuse_prevention      = 0
  }
}

variable "billing_contact" {
  description = "Billing Contact for the AWS Account."
  type        = map(string)
  default     = null
}

variable "operation_contact" {
  description = "Operation Contact for the AWS Account."
  type        = map(string)
  default     = null
}

variable "security_contact" {
  description = "Security Contact for the AWS Account."
  type        = map(string)
  default     = null
}
