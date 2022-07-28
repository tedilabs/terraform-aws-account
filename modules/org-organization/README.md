# org-organization

This module creates following resources.

- `aws_organizations_organization`
- `aws_organizations_policy_attachment` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.65 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_organizations_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the Organization. | `string` | n/a | yes |
| <a name="input_ai_services_opt_out_policy_type_enabled"></a> [ai\_services\_opt\_out\_policy\_type\_enabled](#input\_ai\_services\_opt\_out\_policy\_type\_enabled) | Whether to enable AI services opt-out polices in the Organization. | `bool` | `false` | no |
| <a name="input_all_features_enabled"></a> [all\_features\_enabled](#input\_all\_features\_enabled) | Whether to create AWS Organization with all features or only consolidated billing feature. | `bool` | `true` | no |
| <a name="input_backup_policy_type_enabled"></a> [backup\_policy\_type\_enabled](#input\_backup\_policy\_type\_enabled) | Whether to enable Backup polices in the Organization. | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | List of IDs of the policies to be attached to the Organization. | `list(string)` | `[]` | no |
| <a name="input_service_control_policy_type_enabled"></a> [service\_control\_policy\_type\_enabled](#input\_service\_control\_policy\_type\_enabled) | Whether to enable Service control polices(SCPs) in the Organization. | `bool` | `true` | no |
| <a name="input_tag_policy_type_enabled"></a> [tag\_policy\_type\_enabled](#input\_tag\_policy\_type\_enabled) | Whether to enable Tag polices in the Organization. | `bool` | `false` | no |
| <a name="input_trusted_access_enabled_service_principals"></a> [trusted\_access\_enabled\_service\_principals](#input\_trusted\_access\_enabled\_service\_principals) | List of AWS service principal names for which you want to enable integration with the organization. This is typically in the form of a URL, such as service-abbreviation.amazonaws.com. Organization must `all_featrues_enabled` set to true. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accounts"></a> [accounts](#output\_accounts) | The accounts for the Organization. |
| <a name="output_ai_services_opt_out_policy_type_enabled"></a> [ai\_services\_opt\_out\_policy\_type\_enabled](#output\_ai\_services\_opt\_out\_policy\_type\_enabled) | Whether AI services opt-out polices are enabled. |
| <a name="output_all_features_enabled"></a> [all\_features\_enabled](#output\_all\_features\_enabled) | Whether AWS Organization was configured with all features or only consolidated billing feature. |
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the Organization. |
| <a name="output_backup_policy_type_enabled"></a> [backup\_policy\_type\_enabled](#output\_backup\_policy\_type\_enabled) | Whether Backup polices are enabled. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Organization. |
| <a name="output_master_account"></a> [master\_account](#output\_master\_account) | The master account for the Organization. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Organization. |
| <a name="output_non_master_accounts"></a> [non\_master\_accounts](#output\_non\_master\_accounts) | The non-master accounts for the Organization. |
| <a name="output_root"></a> [root](#output\_root) | The root information of the Organization. |
| <a name="output_service_control_policy_type_enabled"></a> [service\_control\_policy\_type\_enabled](#output\_service\_control\_policy\_type\_enabled) | Whether Service control polices(SCPs) are enabled. |
| <a name="output_tag_policy_type_enabled"></a> [tag\_policy\_type\_enabled](#output\_tag\_policy\_type\_enabled) | Whether Tag polices are enabled. |
| <a name="output_trusted_access_enabled_service_principals"></a> [trusted\_access\_enabled\_service\_principals](#output\_trusted\_access\_enabled\_service\_principals) | List of AWS service principal names which is integrated with the organization. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
