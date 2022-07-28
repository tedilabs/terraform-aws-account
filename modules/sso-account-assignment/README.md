# sso-account-assignment

This module creates following resources.

- `aws_ssoadmin_account_assignment`

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
| [aws_ssoadmin_account_assignment.groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment) | resource |
| [aws_ssoadmin_account_assignment.users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment) | resource |
| [aws_identitystore_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/identitystore_group) | data source |
| [aws_identitystore_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/identitystore_user) | data source |
| [aws_ssoadmin_instances.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |
| [aws_ssoadmin_permission_set.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_permission_set) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The identifier of an AWS account which the assignment willb e created. Typically a 10-12 digit string. | `string` | n/a | yes |
| <a name="input_permission_set_arn"></a> [permission\_set\_arn](#input\_permission\_set\_arn) | The ARN of the Permission Set that the admin wants to grant the principal access to. | `string` | n/a | yes |
| <a name="input_groups"></a> [groups](#input\_groups) | List of names of Group entities who can access to the Permission Set. | `list(string)` | `[]` | no |
| <a name="input_users"></a> [users](#input\_users) | List of names of User entities who can access to the Permission Set. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | The identifier of an AWS account. |
| <a name="output_group_assignments"></a> [group\_assignments](#output\_group\_assignments) | List of groups who can access to the Permission Set. |
| <a name="output_identity_store_id"></a> [identity\_store\_id](#output\_identity\_store\_id) | The ID of SSO Identity Store. |
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | The Amazon Resource Name (ARN) of the SSO Instance. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Account Assignment. |
| <a name="output_permission_set"></a> [permission\_set](#output\_permission\_set) | The Amazon Resource Name (ARN) of the Permission Set |
| <a name="output_user_assignments"></a> [user\_assignments](#output\_user\_assignments) | List of users who can access to the Permission Set. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
