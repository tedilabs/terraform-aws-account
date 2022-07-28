# iam-user

This module creates following resources.

- `aws_iam_user`
- `aws_iam_user_group_membership`
- `aws_iam_user_policy` (optional)
- `aws_iam_user_policy_attachment` (optional)
- `aws_iam_user_login_profile` (optional)
- `aws_iam_access_key` (optional)
- `aws_iam_user_ssh_key` (optional)
- `aws_iam_service_specific_credential` (optional)

## Notes

**If possible, always use PGP encryption to prevent Terraform from keeping unencrypted password and access secret key in state file.**

### Keybase

When `pgp_key` is specified as `keybase:username`, make sure that that user has already uploaded public key to keybase.io. For example, user with username `test` has done it properly and you can [verify it here](https://keybase.io/test/pgp_keys.asc).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_service_specific_credential.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_specific_credential) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_login_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_login_profile) | resource |
| [aws_iam_user_policy.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_user_policy.inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_user_policy_attachment.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_iam_user_ssh_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_ssh_key) | resource |
| [aws_resourcegroups_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) Desired name for the IAM user. | `string` | n/a | yes |
| <a name="input_access_keys"></a> [access\_keys](#input\_access\_keys) | (Optional) A list of Access Keys to associate with the IAM user. This is a set of credentials that allow API requests to be made as an IAM user. Each value of `access_keys` block as defined below.<br>    (Required) `enabled` - Whether to activate the Access Key. | `list(map(bool))` | `[]` | no |
| <a name="input_assumable_roles"></a> [assumable\_roles](#input\_assumable\_roles) | (Optional) List of IAM roles ARNs which can be assumed by the user. | `list(string)` | `[]` | no |
| <a name="input_console_access"></a> [console\_access](#input\_console\_access) | (Optional) The configuration of the AWS console access and password for the user. `console_access` block as defined below.<br>    (Optional) `enabled` - Whether to activate the AWS console access and password.<br>    (Optional) `password_length` - The length of the generated password. Only applies on resource creation. Default value is `20`.<br>    (Optional) `password_reset_required` -  Whether the user should be forced to reset the generated password on first login. Defaults to `true`. | `any` | `{}` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | (Optional) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force\_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed. | `bool` | `false` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | (Optional) A list of IAM Groups to add the user to. | `list(string)` | `[]` | no |
| <a name="input_inline_policies"></a> [inline\_policies](#input\_inline\_policies) | (Optional) Map of inline IAM policies to attach to IAM user. (`name` => `policy`). | `map(string)` | `{}` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_path"></a> [path](#input\_path) | (Optional) Desired path for the IAM user. | `string` | `"/"` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | (Optional) The ARN of the policy that is used to set the permissions boundary for the user. | `string` | `null` | no |
| <a name="input_pgp_key"></a> [pgp\_key](#input\_pgp\_key) | (Optional) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Used to encrypt password and access key. | `string` | `""` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | (Optional) List of IAM policies ARNs to attach to IAM user. | `list(string)` | `[]` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_service_credentials"></a> [service\_credentials](#input\_service\_credentials) | (Optional) A list of service specific credentials to associate with the IAM user. Each value of `service_credentials` block as defined below.<br>    (Required) `service` - The name of the AWS service that is to be associated with the credentials. The service you specify here is the only service that can be accessed using these credentials.<br>    (Optional) `enabled` - Whether to activate the service specific credential. | `any` | `[]` | no |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | (Optional) A list of SSH public keys to associate with the IAM user. Each value of `ssh_keys` block as defined below.<br>    (Required) `public_key` - The SSH public key. The public key must be encoded in ssh-rsa format or PEM format.<br>    (Optional) `encoding` - Specify the public key encoding format. Valid values are `SSH` and `PEM`. To retrieve the public key in ssh-rsa format, use `SSH`. To retrieve the public key in PEM format, use `PEM`.<br>    (Optional) `enabled` - Whether to activate the SSH public key. | `any` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_keys"></a> [access\_keys](#output\_access\_keys) | The list of IAM Access Keys for the user. |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN assigned by AWS for this user. |
| <a name="output_assumable_roles"></a> [assumable\_roles](#output\_assumable\_roles) | List of ARNs of IAM roles which IAM user can assume. |
| <a name="output_console_access"></a> [console\_access](#output\_console\_access) | The information of the AWS console access and password for the user. |
| <a name="output_groups"></a> [groups](#output\_groups) | The list of IAM Groups. |
| <a name="output_inline_policies"></a> [inline\_policies](#output\_inline\_policies) | List of names of inline IAM polices which are attached to IAM user. |
| <a name="output_name"></a> [name](#output\_name) | The user's name. |
| <a name="output_pgp_key"></a> [pgp\_key](#output\_pgp\_key) | PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted). |
| <a name="output_policies"></a> [policies](#output\_policies) | List of ARNs of IAM policies which are atached to IAM user. |
| <a name="output_service_credentials"></a> [service\_credentials](#output\_service\_credentials) | The list of service specific credentials for the user. |
| <a name="output_ssh_keys"></a> [ssh\_keys](#output\_ssh\_keys) | The list of SSH public keys for the user. |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | The unique ID assigned by AWS. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
