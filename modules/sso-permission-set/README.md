# sso-permission-set

This module creates following resources.

- `aws_ssoadmin_permission_set`
- `aws_ssoadmin_managed_policy_attachment` (optional)
- `aws_ssoadmin_permission_set_inline_policy` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_resourcegroups_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |
| [aws_ssoadmin_managed_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_managed_policy_attachment) | resource |
| [aws_ssoadmin_permission_set.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set) | resource |
| [aws_ssoadmin_permission_set_inline_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set_inline_policy) | resource |
| [aws_ssoadmin_instances.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the Permission Set. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description of the Permission Set. | `string` | `"Managed by Terraform."` | no |
| <a name="input_inline_policy"></a> [inline\_policy](#input\_inline\_policy) | The IAM inline policy to attach to a Permission Set. Only supports one IAM inline policy per Permission Set. Creating or updating this resource will automatically Provision the Permission Set to apply the corresponding updates to all assigned accounts. | `string` | `null` | no |
| <a name="input_managed_policies"></a> [managed\_policies](#input\_managed\_policies) | List of ARNs of IAM managed policies to be attached to the Permission Set. | `list(string)` | `[]` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_relay_state"></a> [relay\_state](#input\_relay\_state) | The relay state URL used to redirect users within the application during the federation authentication process. | `string` | `null` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_session_duration"></a> [session\_duration](#input\_session\_duration) | The length of time that the application user sessions are valid in the ISO-8601 standard. | `string` | `"PT1H"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the Permission Set. |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The date the Permission Set was created in RFC3339 format. |
| <a name="output_inline_policy"></a> [inline\_policy](#output\_inline\_policy) | The IAM inline policy which are attached to the Permission Set. |
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | The Amazon Resource Name (ARN) of the SSO Instance. |
| <a name="output_managed_policies"></a> [managed\_policies](#output\_managed\_policies) | List of ARNs of IAM managed policies which are attached to the Permission Set. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Permission Set. |
| <a name="output_relay_state"></a> [relay\_state](#output\_relay\_state) | The relay state URL used to redirect users within the application during the federation authentication process. |
| <a name="output_session_duration"></a> [session\_duration](#output\_session\_duration) | The length of time that the application user sessions are valid in the ISO-8601 standard. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
