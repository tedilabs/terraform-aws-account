variable "ebs_default_encryption" {
  description = <<EOF
  (Optional) The configuration of the EBS default encryption. `ebs_default_encryption` as defined below.
    (Optional) `enabled` - Whether or not default EBS encryption is enabled.
    (Optional) `kms_key` - The ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use to encrypt the EBS volume.
  EOF
  type = object({
    enabled = optional(bool, false)
    kms_key = optional(string)
  })
  default  = {}
  nullable = false
}

variable "ec2_serial_console_enabled" {
  description = "(Optional) Whether serial console access is enabled for the current AWS region."
  type        = bool
  default     = false
  nullable    = false
}

variable "resource_explorer" {
  description = <<EOF
  (Optional) The configuration of the Resource Explorer in the current AWS region. `resource_explorer` as defined below.
    (Optional) `enabled` - Whether or not to enable the Resource Explorer in the current AWS region. Defaults to `true`.
    (Optional) `index_type` - The type of the index. Valid values are `AGGREGATOR`, `LOCAL`. Defaults to `LOCAL`.
    (Optional) `views` - A list of views to create. `views` as defined below.
      (Required) `name` - The name of the view. The name must be no more than 64 characters long, and can include letters, digits, and the dash (-) character. The name must be unique within its AWS Region.
      (Optional) `is_default` - Whether the view is the default view for the AWS Region. Defaults to `false`.
      (Optional) `filter_queries` - A list of filter queries. Specify which resources are included in the results of queries made using this view. The filter string is combined using a logical AND operator. Defaults to `[]` (include all resources).
      (Optional) `additional_resource_attributes` - A list of additional resource attributes. By default, the results include ARN, owner account, Region, service, and resource type. Valid values are `tags`. Defaults to `[]`.
  EOF
  type = object({
    enabled    = optional(bool, true)
    index_type = optional(string, "LOCAL")
    views = optional(list(object({
      name           = string
      is_default     = optional(bool, false)
      filter_queries = optional(list(string), [])

      additional_resource_attributes = optional(set(string), [])
    })), [])
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["AGGREGATOR", "LOCAL"], var.resource_explorer.index_type)
    error_message = "Valid values for `resource_explorer` are `AGGREGATOR`, `LOCAL`."
  }
  validation {
    condition = alltrue([
      for view in var.resource_explorer.views :
      alltrue([
        for attribute in view.additional_resource_attributes :
        contains(["tags"], attribute)
      ])
    ])
    error_message = "Valid values for each values of `additional_resource_attributes` are `tags`."
  }
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

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "(Optional) Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
  nullable    = false
}

variable "resource_group_name" {
  description = "(Optional) The name of Resource Groupolicy. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Groupolicy."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}
