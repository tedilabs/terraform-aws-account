# iam-role

This module creates following resources.

- `aws_iam_role`
- `aws_iam_role_policy` (optional)
- `aws_iam_role_policy_attachment` (optional)
- `aws_iam_instance_profile` (optional)

## Notes

**If possible, always use PGP encryption to prevent Terraform from keeping unencrypted password and access secret key in state file.**

### Keybase

When `pgp_key` is specified as `keybase:username`, make sure that that user has already uploaded public key to keybase.io. For example, user with username `test` has done it properly and you can [verify it here](https://keybase.io/test/pgp_keys.asc).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.30 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.30 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Desired name for the IAM role. | `string` | n/a | yes |
| conditions | Required conditions to assume the role. | <pre>list(object({<br>    key       = string<br>    condition = string<br>    values    = list(string)<br>  }))</pre> | `[]` | no |
| description | The description of the role. | `string` | `""` | no |
| effective\_date | Allow to assume IAM role only after a specific date and time. | `string` | `null` | no |
| expiration\_date | Allow to assume IAM role only before a specific date and time. | `string` | `null` | no |
| force\_detach\_policies | Specifies to force detaching any policies the role has before destroying it. | `bool` | `false` | no |
| inline\_policies | Map of inline IAM policies to attach to IAM role. (`name` => `policy`). | `map(string)` | `{}` | no |
| instance\_profile\_enabled | Controls if Instance Profile should be created. | `bool` | `false` | no |
| max\_session\_duration | Maximum CLI/API session duration in seconds between 3600 and 43200. | `number` | `3600` | no |
| mfa\_required | Whether MFA should be required to assume the role. | `bool` | `false` | no |
| mfa\_ttl | Max age of valid MFA (in seconds) for roles which require MFA. | `number` | `86400` | no |
| path | Desired path for the IAM role. | `string` | `"/"` | no |
| permissions\_boundary | The ARN of the policy that is used to set the permissions boundary for the role. | `string` | `""` | no |
| policies | List of IAM policies ARNs to attach to IAM role. | `list(string)` | `[]` | no |
| source\_ip\_blacklist | A list of source IP addresses or CIDRs denied to assume IAM role from. | `list(string)` | `[]` | no |
| source\_ip\_whitelist | A list of source IP addresses or CIDRs allowed to assume IAM role from. | `list(string)` | `[]` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| trusted\_iam\_entities | A list of ARNs of AWS IAM entities who can assume the role. | `list(string)` | `[]` | no |
| trusted\_oidc\_conditions | Required conditions to assume the role for OIDC providers. | <pre>list(object({<br>    key       = string<br>    condition = string<br>    values    = list(string)<br>  }))</pre> | `[]` | no |
| trusted\_oidc\_providers | A list of OIDC identity providers. Supported types are `amazon`, `aws-cognito`, `aws-iam`, `facebook`, `google`. `type` is required. `url` is required only when `type` is `aws-iam`. | `list(map(string))` | `[]` | no |
| trusted\_saml\_conditions | Required conditions to assume the role for SAML providers. | <pre>list(object({<br>    key       = string<br>    condition = string<br>    values    = list(string)<br>  }))</pre> | `[]` | no |
| trusted\_saml\_providers | A list of ARNs of SAML identity providers in AWS IAM. | `list(string)` | `[]` | no |
| trusted\_services | AWS Services that can assume the role. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN assigned by AWS for this role. |
| description | The description of the role. |
| effective\_date | Allow to assume IAM role only after this date and time. |
| expiration\_date | Allow to assume IAM role only before this date and time. |
| inline\_policies | List of names of inline IAM polices which are attached to IAM role. |
| instance\_profile\_arn | The ARN assigned by AWS for the Instance Profile. |
| instance\_profile\_name | IAM Instance Profile name. |
| instance\_profile\_unique\_id | The unique ID assigned by AWS for the Instance Profile. |
| mfa\_required | Whether MFA should be required to assume the role. |
| mfa\_ttl | Max age of valid MFA (in seconds) for roles which require MFA. |
| name | IAM Role name. |
| policies | List of ARNs of IAM policies which are atached to IAM role. |
| source\_ip\_blacklist | A list of source IP addresses or CIDRs denied to assume IAM role from. |
| source\_ip\_whitelist | A list of source IP addresses or CIDRs allowed to assume IAM role from. |
| unique\_id | The unique ID assigned by AWS. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
