variable "service_quotas" {
  description = "A map of service quotas to request. The key is `<service-code>/<quota-code>` and the value is a desired value to request."
  type        = map(number)
  default     = {}

  validation {
    condition = alltrue([
      for code, quota in var.service_quotas :
      length(split("/", code)) == 2
    ])
    error_message = "Require valid service quota codes. The format is `<service-code>/<quota-code>`."
  }
}

variable "quota_code_translated" {
  description = "Whether to use translated quota code for readability."
  type        = bool
  default     = false
}
