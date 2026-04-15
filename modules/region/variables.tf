variable "region" {
  description = "(Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region."
  type        = string
  default     = null
  nullable    = true
}

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

variable "ebs" {
  description = <<EOF
  (Optional) The configuration of EBS in the current AWS region. `ebs` as defined below.
    (Optional) `default_encryption` - The configuration of the EBS default encryption. `default_encryption` as defined below.
      (Optional) `enabled` - Whether or not default EBS encryption is enabled.
      (Optional) `kms_key` - The ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use to encrypt the EBS volume.
    (Optional) `snapshot_public_access_mode` - The mode in which to enable "Block public access for snapshots" for the region. Valid values are `block-all-sharing`, `block-new-sharing`, `unblocked`. Defaults to `block-new-sharing`.
  EOF
  type = object({
    default_encryption = optional(object({
      enabled = optional(bool, false)
      kms_key = optional(string)
    }), {})
    snapshot_public_access_mode = optional(string, "block-new-sharing")
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["block-all-sharing", "block-new-sharing", "unblocked"], var.ebs.snapshot_public_access_mode)
    error_message = "Valid values for `snapshot_public_access_mode` are `block-all-sharing`, `block-new-sharing`, `unblocked`."
  }
}

variable "ec2" {
  description = <<EOF
  (Optional) The configuration of EC2 in the current AWS region. `ec2` as defined below.
    (Optional) `ami_public_access_mode` - The mode of block public access for AMIs at the account level in the configured AWS Region. Valid values are `block-new-sharing`, `unblocked`. Defaults to `block-new-sharing`.
    (Optional) `instance_metadata_defaults` - The configuration of the regional instance metadata default settings. `instance_metadata_defaults` as defined below.
      (Optional) `http_enabled` - Whether to enable or disable the HTTP metadata endpoint on your instances. Defaults to `null` (No preference).
      (Optional) `http_token_required` - Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2 (IMDSv2). Defaults to `false`. Defaults to `null` (No preference).
      (Optional) `http_put_response_hop_limit` - A desired HTTP PUT response hop limit for instance metadata requests. The larger the number, the further instance metadata requests can travel. Valid values are integer from `1` to `64`. Defaults to `null` (No preference).
      (Optional) `instance_tags_enabled` - Whether to enable the access to instance tags from the instance metadata service. Defaults to `null` (No preference).
    (Optional) `serial_console_enabled` - Whether serial console access is enabled for the current AWS region. Defaults to `false`.
  EOF
  type = object({
    ami_public_access_mode = optional(string, "block-new-sharing")
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

  validation {
    condition     = contains(["block-new-sharing", "unblocked"], var.ec2.ami_public_access_mode)
    error_message = "Valid values for `ami_public_access_mode` are `block-new-sharing`, `unblocked`."
  }
}

variable "ecs" {
  description = <<EOF
  (Optional) The configuration of ECS in the current AWS region. `ecs` as defined below.
    (Optional) `container_insights` - The configuration of Container Insights. `container_insights` as defined below.
      (Optional) `mode` - The default Container Insights setting for new ECS clusters. Valid values are `ENABLED`, `ENHANCED`, `DISABLED`. Defaults to `DISABLED`.
    (Optional) `awsvpc_trunking_enabled` - Whether to enable ENI trunking for `awsvpc` network mode, which allows more ENIs to be attached per container instance. Defaults to `false`.
    (Optional) `dual_stack_ipv6_enabled` - Whether to enable dual-stack IPv6 networking for Fargate tasks. Defaults to `false`.
    (Optional) `default_log_driver_mode` - The default log driver mode for ECS containers. Valid values are `blocking`, `non-blocking`. Defaults to `non-blocking`.
    (Optional) `fargate` - The configuration of the ECS Fargate settings. `fargate` as defined below.
      (Optional) `event_windows` - Whether to enable ECS Fargate maintenance windows. Defaults to `false`.
      (Optional) `fips_mode` - Whether to enable FIPS mode for Fargate. Only available in AWS GovCloud regions. Defaults to `false`.
      (Optional) `task_retirement_wait_period` - The number of days Fargate waits before retiring a task running on a deprecated platform version. Valid values are `0`, `7`, `14`. Defaults to `7`.
  EOF
  type = object({
    container_insights = optional(object({
      mode = optional(string, "DISABLED")
    }), {})
    awsvpc_trunking_enabled = optional(bool, false)
    dual_stack_ipv6_enabled = optional(bool, false)
    default_log_driver_mode = optional(string, "non-blocking")
    fargate = optional(object({
      event_windows = optional(bool, false)
      # fips_mode                   = optional(bool, false)
      task_retirement_wait_period = optional(number, 7)
    }), {})
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["ENABLED", "ENHANCED", "DISABLED"], var.ecs.container_insights.mode)
    error_message = "Valid values for `ecs.container_insights.mode` are `ENABLED`, `ENHANCED`, `DISABLED`."
  }

  validation {
    condition     = contains(["blocking", "non-blocking"], var.ecs.default_log_driver_mode)
    error_message = "Valid values for `ecs.default_log_driver_mode` are `blocking`, `non-blocking`."
  }

  validation {
    condition     = contains([0, 7, 14], var.ecs.fargate.task_retirement_wait_period)
    error_message = "Valid values for `ecs.fargate.task_retirement_wait_period` are `0`, `7`, `14`."
  }
}

variable "rds" {
  description = <<EOF
  (Optional) The configuration of RDS in the current AWS region. `rds` as defined below.
    (Optional) `default_certificate_identifier` - The new default certificate identifier to override the current one with.
  EOF
  type = object({
    default_certificate_identifier = optional(string)
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
      (Optional) `scope` - The root ARN of the account, an organizational unit (OU), or an organization ARN. Defaults to the account.
      (Optional) `filter_queries` - A list of filter queries. Specify which resources are included in the results of queries made using this view. The filter string is combined using a logical AND operator. Defaults to `[]` (include all resources).
      (Optional) `additional_resource_attributes` - A list of additional resource attributes. By default, the results include ARN, owner account, Region, service, and resource type. Valid values are `tags`. Defaults to `[]`.
  EOF
  type = object({
    enabled    = optional(bool, true)
    index_type = optional(string, "LOCAL")
    views = optional(list(object({
      name           = string
      is_default     = optional(bool, false)
      scope          = optional(string)
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

variable "service_quotas" {
  description = <<EOF
  (Optional) The configuration of Service Quotas in the current AWS region. `service_quotas` as defined below.
    (Optional) `requests` - A map of service quotas to request. The key is `<service-code>/<quota-code>` and the value is a desired value to request.
    (Optional) `code_translation_enabled` - Whether to use translated quota code for readability. Defaults to `false`.
    (Optional) `auto_management` - The configuration of Service Quotas auto management. `auto_management` as defined below.
      (Optional) `enabled` - Whether to enable Service Quotas auto management. Defaults to `false`.
      (Optional) `level` - The opt-in level for Service Quotas auto management. Valid values are `ACCOUNT`. Defaults to `ACCOUNT`.
      (Optional) `type` - The opt-in type for Service Quotas auto management. Valid values are `NotifyOnly`, `NotifyAndAdjust`. Defaults to `NotifyOnly`.
      (Optional) `exclusion_list` - A map of service quotas to exclude from auto management. The key is `<service-code>` and the value is a set of `<quota-code>` to exclude for the service.
      (Optional) `notification_configuration` - The ARN of the AWS User Notification Configuration for automatic management notification.
  EOF
  type = object({
    requests                 = optional(map(number), {})
    code_translation_enabled = optional(bool, false)
    auto_management = optional(object({
      enabled                    = optional(bool, false)
      level                      = optional(string, "ACCOUNT")
      type                       = optional(string, "NotifyOnly")
      exclusion_list             = optional(map(set(string)), {})
      notification_configuration = optional(string)
    }), {})
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for code, quota in var.service_quotas.requests :
      length(split("/", code)) == 2
    ])
    error_message = "Require valid service quota codes. The format is `<service-code>/<quota-code>`."
  }
  validation {
    condition     = contains(["ACCOUNT"], var.service_quotas.auto_management.level)
    error_message = "Valid values for `service_quotas.auto_management.level` are `ACCOUNT`."
  }
  validation {
    condition     = contains(["NotifyOnly", "NotifyAndAdjust"], var.service_quotas.auto_management.type)
    error_message = "Valid values for `service_quotas.auto_management.type` are `NotifyOnly`, `NotifyAndAdjust`."
  }
}

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

variable "vpc" {
  description = <<EOF
  (Optional) The configuration of VPC in the current AWS region. `vpc` as defined below.
    (Optional) `availability_zone_groups` - A map of Availability Zone Groups to manage for the current AWS region. The key is the name of Availability Zone Group, the value is a boolean value to enable the group. In this time, disabling Availability Zone Group is not supported on AWS.
    (Optional) `block_public_access_mode` - The mode in which to enable "Block Public Access" for the VPC in the current AWS region. Valid values are `BIDIRECTIONAL`, `INGRESS`, `OFF`. Defaults to `OFF`.
  EOF
  type = object({
    availability_zone_groups = optional(map(bool), {})
    block_public_access_mode = optional(string, "OFF")
  })
  default  = {}
  nullable = false

  validation {
    condition     = contains(["BIDIRECTIONAL", "INGRESS", "OFF"], var.vpc.block_public_access_mode)
    error_message = "Valid values for `block_public_access_mode` are `BIDIRECTIONAL`, `INGRESS`, `OFF`."
  }
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
