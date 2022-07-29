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
  value       = data.aws_region.this.name
}

output "description" {
  description = "The description of the current region in this format: `Location (Region name)`"
  value       = data.aws_region.this.description
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
  }
}

output "ec2" {
  description = <<EOF
  The region-level configurations of EC2 service.
    `serial_console` - The configurations for EC2 Serial Console.
  EOF
  value = {
    serial_console = {
      enabled = aws_ec2_serial_console_access.this.enabled
    }
  }
}

output "service_quotas" {
  description = <<EOF
  The region-level configurations of Service Quotas.
  EOF
  value = {
    for code, quota in aws_servicequotas_service_quota.this :
    code => {
      quota_code    = quota.quota_code
      quota_name    = quota.quota_name
      default_value = quota.default_value
      value         = quota.value
    }
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
