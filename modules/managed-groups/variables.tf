variable "self_service_password_enabled" {
  description = "Whether to create IAM group for the self service password."
  type        = bool
  default     = false
}

variable "self_service_password_name" {
  description = "Desired IAM group name for the self service password. Default name is `self-service-password`."
  type        = string
  default     = ""
}

variable "self_service_mfa_enabled" {
  description = "Whether to create IAM group for the self service mfa."
  type        = bool
  default     = false
}

variable "self_service_mfa_name" {
  description = "Desired IAM group name for the self service mfa. Default name is `self-service-mfa`."
  type        = string
  default     = ""
}
