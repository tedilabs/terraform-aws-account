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
| terraform | >= 0.13 |
| aws | >= 3.27 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.27 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_key\_enabled | Whether to activate IAM access key. | `bool` | `true` | no |
| assumable\_roles | List of IAM roles ARNs which can be assumed by the user. | `list(string)` | `[]` | no |
| create\_access\_key | Whether to create IAM access key. | `bool` | `false` | no |
| create\_login\_profile | Whether to create IAM user login profile. | `bool` | `true` | no |
| force\_destroy | When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force\_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed. | `bool` | `false` | no |
| groups | A list of IAM Groups to add the user to. | `list(string)` | `[]` | no |
| inline\_policies | Map of inline IAM policies to attach to IAM user. (`name` => `policy`). | `map(string)` | `{}` | no |
| name | Desired name for the IAM user. | `string` | n/a | yes |
| password\_length | The length of the generated password | `number` | `20` | no |
| password\_reset\_required | Whether the user should be forced to reset the generated password on first login. | `bool` | `true` | no |
| path | Desired path for the IAM user. | `string` | `"/"` | no |
| permissions\_boundary | The ARN of the policy that is used to set the permissions boundary for the user. | `string` | `""` | no |
| pgp\_key | Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Used to encrypt password and access key. | `string` | `""` | no |
| policies | List of IAM policies ARNs to attach to IAM user. | `list(string)` | `[]` | no |
| ssh\_public\_key | The SSH public key. The public key must be encoded in ssh-rsa format or PEM format. | `string` | `""` | no |
| ssh\_public\_key\_enabled | Whether to activate the SSH public key. | `bool` | `true` | no |
| ssh\_public\_key\_encoding | Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM. | `string` | `"SSH"` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| upload\_ssh\_key | Whether to upload a public ssh key to the IAM user. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| access\_key\_id | The access key ID. |
| access\_key\_status | Active or Inactive. Keys are initially active, but can be made inactive by other means. |
| arn | The ARN assigned by AWS for this user. |
| assumable\_roles | List of ARNs of IAM roles which IAM user can assume. |
| encrypted\_password | The encrypted password, base64 encoded. |
| encrypted\_secret\_access\_key | The encrypted secret, base64 encoded. |
| groups | The list of IAM Groups. |
| inline\_policies | List of names of inline IAM polices which are attached to IAM user. |
| key\_fingerprint | The fingerprint of the PGP key used to encrypt the password. |
| name | The user's name. |
| pgp\_key | PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted). |
| policies | List of ARNs of IAM policies which are atached to IAM user. |
| ses\_smtp\_password | The secret access key converted into an SES SMTP password. |
| ssh\_public\_key\_fingerprint | The MD5 message digest of the SSH public key. |
| ssh\_public\_key\_id | The unique identifier for the SSH public key. |
| unique\_id | The unique ID assigned by AWS. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
