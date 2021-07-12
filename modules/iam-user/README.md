# iam-user

This module creates following resources.

- `aws_iam_user`
- `aws_iam_user_group_membership`
- `aws_iam_user_login_profile` (optional)
- `aws_iam_access_key` (optional)
- `aws_iam_user_ssh_key` (optional)
- `aws_iam_user_policy` (optional)
- `aws_iam_user_policy_attachment` (optional)

## Notes

**If possible, always use PGP encryption to prevent Terraform from keeping unencrypted password and access secret key in state file.**

### Keybase

When `pgp_key` is specified as `keybase:username`, make sure that that user has already uploaded public key to keybase.io. For example, user with username `test` has done it properly and you can [verify it here](https://keybase.io/test/pgp_keys.asc).

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
| [aws_iam_access_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
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
| <a name="input_name"></a> [name](#input\_name) | Desired name for the IAM user. | `string` | n/a | yes |
| <a name="input_access_key_enabled"></a> [access\_key\_enabled](#input\_access\_key\_enabled) | Whether to activate IAM access key. | `bool` | `true` | no |
| <a name="input_assumable_roles"></a> [assumable\_roles](#input\_assumable\_roles) | List of IAM roles ARNs which can be assumed by the user. | `list(string)` | `[]` | no |
| <a name="input_create_access_key"></a> [create\_access\_key](#input\_create\_access\_key) | Whether to create IAM access key. | `bool` | `false` | no |
| <a name="input_create_login_profile"></a> [create\_login\_profile](#input\_create\_login\_profile) | Whether to create IAM user login profile. | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force\_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed. | `bool` | `false` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | A list of IAM Groups to add the user to. | `list(string)` | `[]` | no |
| <a name="input_inline_policies"></a> [inline\_policies](#input\_inline\_policies) | Map of inline IAM policies to attach to IAM user. (`name` => `policy`). | `map(string)` | `{}` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_password_length"></a> [password\_length](#input\_password\_length) | The length of the generated password | `number` | `20` | no |
| <a name="input_password_reset_required"></a> [password\_reset\_required](#input\_password\_reset\_required) | Whether the user should be forced to reset the generated password on first login. | `bool` | `true` | no |
| <a name="input_path"></a> [path](#input\_path) | Desired path for the IAM user. | `string` | `"/"` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the user. | `string` | `""` | no |
| <a name="input_pgp_key"></a> [pgp\_key](#input\_pgp\_key) | Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Used to encrypt password and access key. | `string` | `""` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | List of IAM policies ARNs to attach to IAM user. | `list(string)` | `[]` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH public key. The public key must be encoded in ssh-rsa format or PEM format. | `string` | `""` | no |
| <a name="input_ssh_public_key_enabled"></a> [ssh\_public\_key\_enabled](#input\_ssh\_public\_key\_enabled) | Whether to activate the SSH public key. | `bool` | `true` | no |
| <a name="input_ssh_public_key_encoding"></a> [ssh\_public\_key\_encoding](#input\_ssh\_public\_key\_encoding) | Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM. | `string` | `"SSH"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_upload_ssh_key"></a> [upload\_ssh\_key](#input\_upload\_ssh\_key) | Whether to upload a public ssh key to the IAM user. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key_id"></a> [access\_key\_id](#output\_access\_key\_id) | The access key ID. |
| <a name="output_access_key_status"></a> [access\_key\_status](#output\_access\_key\_status) | Active or Inactive. Keys are initially active, but can be made inactive by other means. |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN assigned by AWS for this user. |
| <a name="output_assumable_roles"></a> [assumable\_roles](#output\_assumable\_roles) | List of ARNs of IAM roles which IAM user can assume. |
| <a name="output_encrypted_password"></a> [encrypted\_password](#output\_encrypted\_password) | The encrypted password, base64 encoded. |
| <a name="output_encrypted_secret_access_key"></a> [encrypted\_secret\_access\_key](#output\_encrypted\_secret\_access\_key) | The encrypted secret, base64 encoded. |
| <a name="output_groups"></a> [groups](#output\_groups) | The list of IAM Groups. |
| <a name="output_inline_policies"></a> [inline\_policies](#output\_inline\_policies) | List of names of inline IAM polices which are attached to IAM user. |
| <a name="output_key_fingerprint"></a> [key\_fingerprint](#output\_key\_fingerprint) | The fingerprint of the PGP key used to encrypt the password. |
| <a name="output_name"></a> [name](#output\_name) | The user's name. |
| <a name="output_pgp_key"></a> [pgp\_key](#output\_pgp\_key) | PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted). |
| <a name="output_policies"></a> [policies](#output\_policies) | List of ARNs of IAM policies which are atached to IAM user. |
| <a name="output_ses_smtp_password"></a> [ses\_smtp\_password](#output\_ses\_smtp\_password) | The secret access key converted into an SES SMTP password. |
| <a name="output_ssh_public_key_fingerprint"></a> [ssh\_public\_key\_fingerprint](#output\_ssh\_public\_key\_fingerprint) | The MD5 message digest of the SSH public key. |
| <a name="output_ssh_public_key_id"></a> [ssh\_public\_key\_id](#output\_ssh\_public\_key\_id) | The unique identifier for the SSH public key. |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | The unique ID assigned by AWS. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
