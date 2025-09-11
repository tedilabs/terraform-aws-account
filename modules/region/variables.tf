variable "cloudwatch" {
  description = <<EOF
  (Optional) The configuration of CloudWatch in the current AWS region. `cloudwatch` as defined below.
    (Optional) `oam_sink` - A configuration of CloudWatch OAM(Observability Access Manager) sink. `oam_sink` as defined below.
      (Required) `name` - The name of the CloudWatch OAM sink.
      (Optional) `telemetry_types` - A set of the telemetry types can be shared with it. Valid values are `AWS::CloudWatch::Metric`, `AWS::Logs::LogGroup`, `AWS::XRay::Trace`, `AWS::ApplicationInsights::Application`, `AWS::InternetMonitor::Monitor`.
      (Optional) `allowed_source_accounts` - A list of the IDs of AWS accounts that will share data with this monitoring account.
      (Optional) `allowed_source_organizations` - A list of the organization IDs of AWS accounts that will share data with this monitoring account.
      (Optional) `allowed_source_organization_paths` - A list of the organization paths of the AWS accounts that will share data with this monitoring account.
      (Optional) `tags` - A map of tags to add to the resource.
  EOF
  type = object({
    oam_sink = optional(object({
      name                              = string
      telemetry_types                   = optional(set(string), [])
      allowed_source_accounts           = optional(list(string), [])
      allowed_source_organizations      = optional(list(string), [])
      allowed_source_organization_paths = optional(list(string), [])
      tags                              = optional(map(string), {})
    }))
  })
  default  = {}
  nullable = false
}

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

variable "ec2" {
  description = <<EOF
  (Optional) The configuration of EC2 in the current AWS region. `ec2` as defined below.
    (Optional) `ami_public_access_enabled` - Whether to allow or block public access for AMIs at the account level to prevent the public sharing of your AMIs in this region. Defaults to `false`.
    (Optional) `instance_metadata_defaults` - The configuration of the regional instance metadata default settings. `instance_metadata_defaults` as defined below.
      (Optional) `http_enabled` - Whether to enable or disable the HTTP metadata endpoint on your instances. Defaults to `null` (No preference).
      (Optional) `http_token_required` - Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2 (IMDSv2). Defaults to `false`. Defaults to `null` (No preference).
      (Optional) `http_put_response_hop_limit` - A desired HTTP PUT response hop limit for instance metadata requests. The larger the number, the further instance metadata requests can travel. Valid values are integer from `1` to `64`. Defaults to `null` (No preference).
      (Optional) `instance_tags_enabled` - Whether to enable the access to instance tags from the instance metadata service. Defaults to `null` (No preference).
    (Optional) `serial_console_enabled` - Whether serial console access is enabled for the current AWS region. Defaults to `false`.
  EOF
  type = object({
    ami_public_access_enabled = optional(bool, false)
    instance_metadata_defaults = optional(object({
      http_enabled                = optional(bool)
      http_token_required         = optional(bool)
      http_put_response_hop_limit = optional(number)
      instance_tags_enabled       = optional(bool)
    }), {})
    serial_console_enabled = optional(bool, false)
  })
  default  = {}
  nullable = false
}

variable "guardduty" {
  description = <<EOF
  (Optional) The configuration of GuardDuty in the current AWS region. `guardduty` as defined below.
    (Optional) `delegated_administrator` - The AWS account ID for the account to designate as the delegated Amazon GuardDuty administrator account for the organization. The delegated administrator will be assigned the two GuardDuty roles required to administer GuardDuty policy in your organization. Can be used in only management account of the organization.
  EOF
  type = object({
    delegated_administrator = optional(string)
  })
  default  = {}
  nullable = false
}

variable "inspector" {
  description = <<EOF
  (Optional) The configuration of Inspector in the current AWS region. `inspector` as defined below.
    (Optional) `delegated_administrator` - The AWS account ID for the account to designate as the delegated Amazon Inspector administrator account for the organization. The delegated administrator is granted all of the permissions required to administer Inspector for your organization. When you choose a delegated administrator, Inspector is activated for that account. Can be used in only management account of the organization.
  EOF
  type = object({
    delegated_administrator = optional(string)
  })
  default  = {}
  nullable = false
}

variable "macie" {
  description = <<EOF
  (Optional) The configuration of Macie in the current AWS region. `macie` as defined below.
    (Optional) `delegated_administrator` - The AWS account ID for the account to designate as the delegated Amazon Macie administrator account for the organization. This can be configured only if Macie is enabled for the organization. The account must be a management account of the organization.
  EOF
  type = object({
    delegated_administrator = optional(string)
  })
  default  = {}
  nullable = false
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
variable "ses" {
  description = <<EOF
  (Optional) The configuration of the SES (Simple Email Service) for the account. `ses` as defined below.
    (Optional) `suppression_reasons` - A set of the reasons that email addresses will be automatically added to the suppression list for your account. Valid values are `COMPLAINT`, `BOUNCE`.
  EOF
  type = object({
    suppression_reasons = optional(set(string), ["COMPLAINT", "BOUNCE"])
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for reason in var.ses.suppression_reasons :
      contains(["COMPLAINT", "BOUNCE"], reason)
    ])
    error_message = "Valid values for `suppression_reasons` are `COMPLAINT` and `BOUNCE`."
  }
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




variable "resource_group" {
  description = <<EOF
  (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.
    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.
    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.
    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`.
  EOF
  type = object({
    enabled     = optional(bool, true)
    name        = optional(string, "")
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}
