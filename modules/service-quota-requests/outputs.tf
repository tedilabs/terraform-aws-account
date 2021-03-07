output "region" {
  description = "The region of AWS."
  value       = data.aws_region.this.name
}

output "service_quotas" {
  description = "The information for requested service quotas."
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
