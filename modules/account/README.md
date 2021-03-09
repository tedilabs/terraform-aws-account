# account

This module creates following resources.

- `aws_iam_account_alias`
- `aws_iam_account_password_policy`

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
| name | The name for the AWS account. Used for the account alias. | `string` | n/a | yes |
| password\_policy | Password Policy for the AWS account. | <pre>object({<br>    minimum_password_length        = number<br>    require_numbers                = bool<br>    require_symbols                = bool<br>    require_lowercase_characters   = bool<br>    require_uppercase_characters   = bool<br>    allow_users_to_change_password = bool<br>    hard_expiry                    = bool<br>    max_password_age               = number<br>    password_reuse_prevention      = number<br>  })</pre> | <pre>{<br>  "allow_users_to_change_password": true,<br>  "hard_expiry": false,<br>  "max_password_age": 0,<br>  "minimum_password_length": 8,<br>  "password_reuse_prevention": 0,<br>  "require_lowercase_characters": true,<br>  "require_numbers": true,<br>  "require_symbols": true,<br>  "require_uppercase_characters": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The AWS Account ID. |
| name | Name of the AWS account. The account alias. |
| password\_policy | Password Policy for the AWS Account. `expire_passwords` indicates whether passwords in the account expire. Returns `true` if `max_password_age` contains a value greater than 0. |
| signin\_url | The URL to signin for the AWS account. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
