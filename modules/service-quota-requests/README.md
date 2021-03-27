# service-quota-requests

This module creates following resources.

- `aws_servicequotas_service_quota` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.34 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.34 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| quota\_code\_translated | Whether to use translated quota code for readability. | `bool` | `false` | no |
| service\_quotas | A map of service quotas to request. The key is `<service-code>/<quota-code>` and the value is a desired value to request. | `map(number)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| region | The region of AWS. |
| service\_quotas | The information for requested service quotas. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
