resource "aws_servicequotas_service_quota" "this" {
  for_each = {
    for code, quota in var.service_quotas_request :
    code => {
      service_code = split("/", code)[0]
      quota_code   = split("/", code)[1]
      value        = quota
    }
  }

  service_code = each.value.service_code
  quota_code = (
    var.service_quotas_code_translation_enabled
    ? local.quota_codes[each.key]
    : each.value.quota_code
  )
  value = each.value.value
}
