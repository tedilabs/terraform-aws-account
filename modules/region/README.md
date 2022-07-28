# region

This module creates following resources.

- `aws_ebs_encryption_by_default`
- `aws_ebs_default_kms_key` (optional)
- `aws_ec2_serial_console_access`
- `aws_servicequotas_service_quota` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ebs_default_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_default_kms_key) | resource |
| [aws_ebs_encryption_by_default.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default) | resource |
| [aws_ec2_serial_console_access.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_serial_console_access) | resource |
| [aws_servicequotas_service_quota.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/servicequotas_service_quota) | resource |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ebs_default_encryption_enabled"></a> [ebs\_default\_encryption\_enabled](#input\_ebs\_default\_encryption\_enabled) | (Optional) Whether or not default EBS encryption is enabled. | `bool` | `false` | no |
| <a name="input_ebs_default_encryption_kms_key"></a> [ebs\_default\_encryption\_kms\_key](#input\_ebs\_default\_encryption\_kms\_key) | (Optional) The ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use to encrypt the EBS volume. | `string` | `null` | no |
| <a name="input_ec2_serial_console_enabled"></a> [ec2\_serial\_console\_enabled](#input\_ec2\_serial\_console\_enabled) | (Optional) Whether serial console access is enabled for the current AWS region. | `bool` | `false` | no |
| <a name="input_service_quotas_code_translation_enabled"></a> [service\_quotas\_code\_translation\_enabled](#input\_service\_quotas\_code\_translation\_enabled) | Whether to use translated quota code for readability. | `bool` | `false` | no |
| <a name="input_service_quotas_request"></a> [service\_quotas\_request](#input\_service\_quotas\_request) | (Optional) A map of service quotas to request. The key is `<service-code>/<quota-code>` and the value is a desired value to request. | `map(number)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_code"></a> [code](#output\_code) | The short code of the current region. |
| <a name="output_description"></a> [description](#output\_description) | The description of the current region in this format: `Location (Region name)` |
| <a name="output_ebs"></a> [ebs](#output\_ebs) | The region-level configurations of EBS service.<br>    `default_encryption` - The configurations for EBS Default Encryption. |
| <a name="output_ec2"></a> [ec2](#output\_ec2) | The region-level configurations of EC2 service.<br>    `serial_console` - The configurations for EC2 Serial Console. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the current region. |
| <a name="output_name"></a> [name](#output\_name) | The name of the current region. |
| <a name="output_service_quotas"></a> [service\_quotas](#output\_service\_quotas) | The region-level configurations of Service Quotas. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
