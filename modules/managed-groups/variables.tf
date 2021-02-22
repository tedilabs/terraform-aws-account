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
