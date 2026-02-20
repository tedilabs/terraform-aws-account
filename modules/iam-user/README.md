# iam-user

This module creates following resources.

- `aws_iam_user`
- `aws_iam_user_group_membership`
- `aws_iam_user_policies_exclusive` (optional)
- `aws_iam_user_policy` (optional)
- `aws_iam_user_policy_attachment` (optional)
- `aws_iam_user_policy_attachments_exclusive` (optional)
- `aws_iam_user_login_profile` (optional)
- `aws_iam_access_key` (optional)
- `aws_iam_user_ssh_key` (optional)
- `aws_iam_service_specific_credential` (optional)
- `aws_iam_signing_certificate` (optional)

## Notes

**If possible, always use PGP encryption to prevent Terraform from keeping unencrypted password and access secret key in state file.**

### Keybase

When `pgp_key` is specified as `keybase:username`, make sure that that user has already uploaded public key to keybase.io. For example, user with username `test` has done it properly and you can [verify it here](https://keybase.io/test/pgp_keys.asc).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.33.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_service_specific_credential.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_specific_credential) | resource |
| [aws_iam_signing_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_signing_certificate) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_login_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_login_profile) | resource |
| [aws_iam_user_policies_exclusive.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policies_exclusive) | resource |
| [aws_iam_user_policy.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_user_policy.inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_user_policy_attachment.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_iam_user_policy_attachments_exclusive.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachments_exclusive) | resource |
| [aws_iam_user_ssh_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_ssh_key) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) Desired name for the IAM user. | `string` | n/a | yes |
| <a name="input_access_keys"></a> [access\_keys](#input\_access\_keys) | (Optional) A list of Access Keys to associate with the IAM user. This is a set of credentials that allow API requests to be made as an IAM user. The IAM User can have a maximum of two Access Keys (active or inactive) at a time. Each item of `access_keys` as defined below.<br/>    (Optional) `enabled` - Whether to activate the Access Key. Defaults to `true`. | <pre>list(object({<br/>    enabled = optional(bool, true)<br/>  }))</pre> | `[]` | no |
| <a name="input_assumable_roles"></a> [assumable\_roles](#input\_assumable\_roles) | (Optional) A set of IAM roles ARNs which can be assumed by the user. | `set(string)` | `[]` | no |
| <a name="input_console_access"></a> [console\_access](#input\_console\_access) | (Optional) A configuration of the AWS console access and password for the user. `console_access` as defined below.<br/>    (Optional) `enabled` - Whether to activate the AWS console access and password. Defaults to `true`.<br/>    (Optional) `password_length` - The length of the generated password. Only applies on resource creation. Defaults to `20`.<br/>    (Optional) `password_reset_required` -  Whether the user should be forced to reset the generated password on first login. Defaults to `true`. | <pre>object({<br/>    enabled                 = optional(bool, true)<br/>    password_length         = optional(number, 20)<br/>    password_reset_required = optional(bool, true)<br/>  })</pre> | `{}` | no |
| <a name="input_exclusive_inline_policy_management_enabled"></a> [exclusive\_inline\_policy\_management\_enabled](#input\_exclusive\_inline\_policy\_management\_enabled) | (Optional) Whether to enable exclusive management for inline IAM policies of the IAM user. This includes removal of inline IAM policies which are not explicitly configured. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_exclusive_policy_management_enabled"></a> [exclusive\_policy\_management\_enabled](#input\_exclusive\_policy\_management\_enabled) | (Optional) Whether to enable exclusive management for managed IAM policies of the IAM user. This includes removal of managed IAM policies which are not explicitly configured. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | (Optional) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force\_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | (Optional) A set of IAM Groups to add the user to. | `set(string)` | `[]` | no |
| <a name="input_inline_policies"></a> [inline\_policies](#input\_inline\_policies) | (Optional) A map of inline IAM policies to attach to IAM user. The policy is a JSON document that you attach to an identity to specify what API actions you're allowing or denying for that identity, and under which conditions. Each key is the name of the policy, and the value is the policy document. | `map(string)` | `{}` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_path"></a> [path](#input\_path) | (Optional) Desired path for the IAM user. Defaults to `/`. | `string` | `"/"` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | (Optional) The ARN of the policy that is used to set the permissions boundary for the user. | `string` | `null` | no |
| <a name="input_pgp_key"></a> [pgp\_key](#input\_pgp\_key) | (Optional) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Used to encrypt password and access key. | `string` | `""` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | (Optional) A set of IAM policies ARNs to attach to IAM user. | `set(string)` | `[]` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_service_credentials"></a> [service\_credentials](#input\_service\_credentials) | (Optional) A list of service specific credentials to associate with the IAM user. Each value of `service_credentials` block as defined below.<br/>    (Required) `service` - The name of the AWS service that is to be associated with the credentials. The service you specify here is the only service that can be accessed using these credentials.<br/>    (Optional) `enabled` - Whether to activate the service specific credential. Defaults to `true`. | <pre>list(object({<br/>    service = string<br/>    enabled = optional(bool, true)<br/>  }))</pre> | `[]` | no |
| <a name="input_signing_certificates"></a> [signing\_certificates](#input\_signing\_certificates) | (Optional) A list of X.509 signing certificates to associate with the IAM user. Each item of `signing_certificates` as defined below.<br/>    (Optional) `enabled` - Whether to activate the signing certificate. Defaults to `true`.<br/>    (Required) `certificate` - The contents of the signing certificate in PEM encoded format. | <pre>list(object({<br/>    enabled          = optional(bool, true)<br/>    certificate_body = string<br/>  }))</pre> | `[]` | no |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | (Optional) A list of SSH public keys to associate with the IAM user. can have a maximum of five SSH public keys (active or inactive) at a time. Each item of `ssh_keys` as defined below.<br/>    (Optional) `enabled` - Whether to activate the SSH public key. Defaults to `true`.<br/>    (Required) `public_key` - The SSH public key. The public key must be encoded in ssh-rsa format or PEM format.<br/>    (Optional) `encoding` - Specify the public key encoding format. Valid values are `SSH` and `PEM`. To retrieve the public key in ssh-rsa format, use `SSH`. To retrieve the public key in PEM format, use `PEM`. | <pre>list(object({<br/>    enabled    = optional(bool, true)<br/>    public_key = string<br/>    encoding   = optional(string, "SSH")<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_keys"></a> [access\_keys](#output\_access\_keys) | The list of IAM Access Keys for the user. |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the IAM user. |
| <a name="output_assumable_roles"></a> [assumable\_roles](#output\_assumable\_roles) | A set of ARNs of IAM roles which IAM user can assume. |
| <a name="output_console_access"></a> [console\_access](#output\_console\_access) | The information of the AWS console access and password for the user. |
| <a name="output_exclusive_inline_policy_management_enabled"></a> [exclusive\_inline\_policy\_management\_enabled](#output\_exclusive\_inline\_policy\_management\_enabled) | Whether exclusive inline policy management is enabled for the IAM user. |
| <a name="output_exclusive_policy_management_enabled"></a> [exclusive\_policy\_management\_enabled](#output\_exclusive\_policy\_management\_enabled) | Whether exclusive policy management is enabled for the IAM user. |
| <a name="output_groups"></a> [groups](#output\_groups) | A set of IAM Groups which the user is a member of. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IAM user. |
| <a name="output_inline_policies"></a> [inline\_policies](#output\_inline\_policies) | A set of names of inline IAM polices which are attached to IAM user. |
| <a name="output_name"></a> [name](#output\_name) | The user's name. |
| <a name="output_path"></a> [path](#output\_path) | The path of the IAM user. |
| <a name="output_pgp_key"></a> [pgp\_key](#output\_pgp\_key) | PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted). |
| <a name="output_policies"></a> [policies](#output\_policies) | A set of ARNs of IAM policies which are atached to IAM user. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_service_credentials"></a> [service\_credentials](#output\_service\_credentials) | The list of service specific credentials for the user. |
| <a name="output_signing_certificates"></a> [signing\_certificates](#output\_signing\_certificates) | The list of X.509 signing certificates for the user. |
| <a name="output_ssh_keys"></a> [ssh\_keys](#output\_ssh\_keys) | The list of SSH public keys for the user. |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | The unique ID assigned by AWS. |
<!-- END_TF_DOCS -->
