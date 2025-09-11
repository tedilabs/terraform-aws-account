output "region" {
  description = "The AWS region this module resources resides in."
  value       = var.region
}

output "id" {
  description = "The ID of the current region."
  value       = data.aws_region.this.id
}

output "code" {
  description = "The short code of the current region."
  value       = local.region_codes[data.aws_region.this.id]
}

output "name" {
  description = "The name of the current region."
  value       = data.aws_region.this.region
}

output "description" {
  description = "The description of the current region in this format: `Location (Region name)`"
  value       = data.aws_region.this.description
}

output "cloudwdatch" {
  description = <<EOF
  The region-level configurations of CloudWatch service.
    `oam_sink` - A configuration of CloudWatch OAM(Observability Access Manager) sink.
  EOF
  value = {
    oam_sink = one(module.cloudwatch_oam_sink[*])
  }
}

output "ebs" {
  description = <<EOF
  The region-level configurations of EBS service.
    `default_encryption` - The configurations for EBS Default Encryption.
  EOF
  value = {
    default_encryption = {
      enabled = aws_ebs_encryption_by_default.this.enabled
      kms_key = one(aws_ebs_default_kms_key.this[*].key_arn)
    }
    snapshot_public_access_mode = aws_ebs_snapshot_block_public_access.this.state
  }
}

output "ec2" {
  description = <<EOF
  The region-level configurations of EC2 service.
    `ami_public_access_enabled` - Whether to allow or block public access for AMIs at the account level to prevent the public sharing of your AMIs in this region.
    `serial_console_enabled` - Whether serial console access is enabled for the current AWS region.
  EOF
  value = {
    ami_public_access_mode     = aws_ec2_image_block_public_access.this.state
    instance_metadata_defaults = var.ec2.instance_metadata_defaults
    serial_console_enabled     = aws_ec2_serial_console_access.this.enabled
  }
}

output "guardduty" {
  description = <<EOF
  The region-level configurations of GuardDuty service.
    `delegated_administrator` - The AWS account ID for the account to designate as the delegated Amazon GuardDuty administrator account for the organization.
  EOF
  value = {
    delegated_administrator = one(aws_guardduty_organization_admin_account.this[*].admin_account_id)
  }
}

output "inspector" {
  description = <<EOF
  The region-level configurations of Inspector service.
    `delegated_administrator` - The AWS account ID for the account to designate as the delegated Amazon Inspector administrator account for the organization.
  EOF
  value = {
    delegated_administrator = one(aws_inspector2_delegated_admin_account.this[*].account_id)
  }
}

output "macie" {
  description = <<EOF
  The region-level configurations of Macie service.
    `delegated_administrator` - The AWS account ID for the account to designate as the delegated Amazon Macie administrator account for the organization.
  EOF
  value = {
    delegated_administrator = one(aws_macie2_organization_admin_account.this[*].admin_account_id)
  }
}

output "resource_explorer" {
  description = <<EOF
  The region-level configurations of Resource Explorer service.
    `enabled` - Whether the Resource Explorer is enabled in the current AWS region.
    `index_type` - The type of the index.
    `views` - The list of views.
  EOF
  value = {
    enabled    = length(aws_resourceexplorer2_index.this) > 0
    index_arn  = one(aws_resourceexplorer2_index.this[*].arn)
    index_type = one(aws_resourceexplorer2_index.this[*].type)
    views = {
      for name, view in aws_resourceexplorer2_view.this :
      name => {
        arn                            = view.arn
        name                           = view.name
        is_default                     = view.default_view
        scope                          = view.scope
        filter_queries                 = view.filters[*].filter_string
        additional_resource_attributes = view.included_property[*].name
      }
    }
  }
}

output "service_quotas" {
  description = <<EOF
  The region-level configurations of Service Quotas.
  EOF
  value = {
    requests = {
      for code, quota in aws_servicequotas_service_quota.this :
      code => {
        quota_code    = quota.quota_code
        quota_name    = quota.quota_name
        default_value = quota.default_value
        value         = quota.value
      }
    }
  }
}

output "ses" {
  description = <<EOF
  The region-level configurations of SES service.
    `suppression_reasons` - A set of the reasons that email addresses will be automatically added to the suppression list for your account.
  EOF
  value = {
    suppression_reasons = aws_sesv2_account_suppression_attributes.this.suppressed_reasons
  }
}

output "vpc" {
  description = <<EOF
  The region-level configurations of VPC.
  EOF
  value = {
    availability_zone_groups = {
      for name, group in aws_ec2_availability_zone_group.this :
      name => group.opt_in_status == "opted-in"
    }
  }
}

output "resource_group" {
  description = "The resource group created to manage resources in this module."
  value = merge(
    {
      enabled = var.resource_group.enabled && var.module_tags_enabled
    },
    (var.resource_group.enabled && var.module_tags_enabled
      ? {
        arn  = module.resource_group[0].arn
        name = module.resource_group[0].name
      }
      : {}
    )
  )
}
