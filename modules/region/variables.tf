variable "ebs_default_encryption_enabled" {
  description = "(Optional) Whether or not default EBS encryption is enabled."
  type        = bool
  default     = false
  nullable    = false
}

variable "ebs_default_encryption_kms_key" {
  description = "(Optional) The ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use to encrypt the EBS volume."
  type        = string
  default     = null
}

variable "ec2_serial_console_enabled" {
  description = "(Optional) Whether serial console access is enabled for the current AWS region."
  type        = bool
  default     = false
  nullable    = false
}

variable "service_quotas_request" {
  description = "(Optional) A map of service quotas to request. The key is `<service-code>/<quota-code>` and the value is a desired value to request."
  type        = map(number)
  default     = {}
  nullable    = false

  validation {
    condition = alltrue([
      for code, quota in var.service_quotas_request :
      length(split("/", code)) == 2
    ])
    error_message = "Require valid service quota codes. The format is `<service-code>/<quota-code>`."
  }
}

variable "service_quotas_code_translation_enabled" {
  description = "(Optional) Whether to use translated quota code for readability."
  type        = bool
  default     = false
  nullable    = false
}

variable "vpc_availability_zone_groups" {
  description = "(Optional) The configurations to manage Availability Zone Groups for the current AWS region. The key is the name of Availability Zone Group, the value is a boolean value to enable the group. In this time, disabling Availability Zone Group is not supported on AWS."
  type        = map(bool)
  default     = {}
  nullable    = false
}
