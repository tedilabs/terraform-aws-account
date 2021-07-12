# service-quota-requests

This module creates following resources.

- `aws_servicequotas_service_quota` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.49.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_servicequotas_service_quota.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/servicequotas_service_quota) | resource |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_quota_code_translated"></a> [quota\_code\_translated](#input\_quota\_code\_translated) | Whether to use translated quota code for readability. | `bool` | `false` | no |
| <a name="input_service_quotas"></a> [service\_quotas](#input\_service\_quotas) | A map of service quotas to request. The key is `<service-code>/<quota-code>` and the value is a desired value to request. | `map(number)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_region"></a> [region](#output\_region) | The region of AWS. |
| <a name="output_service_quotas"></a> [service\_quotas](#output\_service\_quotas) | The information for requested service quotas. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
