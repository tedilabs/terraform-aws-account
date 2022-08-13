# org-account

This module creates following resources.

- `aws_organizations_account`
- `aws_organizations_policy_attachment` (optional)
- `aws_organizations_delegated_administrator` (optional)
- `aws_macie2_organization_admin_account` (optional)
- `aws_fms_admin_account` (optional)

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
| [aws_organizations_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_delegated_administrator.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_delegated_administrator) | resource |
| [aws_organizations_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_resourcegroups_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email"></a> [email](#input\_email) | The email address of the owner to assign to the new member account. This email address must not already be associated with another AWS account. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A friendly name for the member account. | `string` | n/a | yes |
| <a name="input_delegated_services"></a> [delegated\_services](#input\_delegated\_services) | List of service principals of the AWS service for which you want to make the member account a delegated administrator. | `list(string)` | `[]` | no |
| <a name="input_iam_user_access_to_billing_allowed"></a> [iam\_user\_access\_to\_billing\_allowed](#input\_iam\_user\_access\_to\_billing\_allowed) | If true, the new account enables IAM users to access account billing information if they have the required permissions. If false, then only the root user of the new account can access account billing information. | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | Parent Organizational Unit ID or Root ID for the account. Defaults to the Organization default Root ID. A configuration must be present for this argument to perform drift detection. | `string` | `null` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | List of IDs of the policies to be attached to the Account. | `list(string)` | `[]` | no |
| <a name="input_preconfigured_adminitrator_role_name"></a> [preconfigured\_adminitrator\_role\_name](#input\_preconfigured\_adminitrator\_role\_name) | The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the master account, allowing users in the master account to assume the role, as permitted by the master account administrator. The role has administrator permissions in the new member account. | `string` | `null` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of this account. |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The datetime which this account joined to the organization. |
| <a name="output_created_by"></a> [created\_by](#output\_created\_by) | The method how this account joined to the organization. |
| <a name="output_delegated_services"></a> [delegated\_services](#output\_delegated\_services) | The method how this account joined to the organization. |
| <a name="output_email"></a> [email](#output\_email) | The email address of this account. |
| <a name="output_iam_user_access_to_billing_allowed"></a> [iam\_user\_access\_to\_billing\_allowed](#output\_iam\_user\_access\_to\_billing\_allowed) | Whether accessing account billing information by IAM User is allowed. |
| <a name="output_id"></a> [id](#output\_id) | The ID of this account. |
| <a name="output_name"></a> [name](#output\_name) | The name of this account. |
| <a name="output_parent_id"></a> [parent\_id](#output\_parent\_id) | The ID of the parent Organizational Unit. |
| <a name="output_preconfigured_adminitrator_role_name"></a> [preconfigured\_adminitrator\_role\_name](#output\_preconfigured\_adminitrator\_role\_name) | The name of an IAM role that allow users in the master account to assume as administrator. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
