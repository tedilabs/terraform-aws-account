# managed_group

This module creates following resources.

- `aws_iam_group`
- `aws_iam_group_policy` (optional)
- `aws_iam_group_policy_attachment` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.34 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.34 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| self\_service\_mfa\_enabled | Whether to create IAM group for the self service mfa. | `bool` | `false` | no |
| self\_service\_mfa\_name | Desired IAM group name for the self service mfa. Default name is `self-service-mfa`. | `string` | `""` | no |
| self\_service\_password\_enabled | Whether to create IAM group for the self service password. | `bool` | `false` | no |
| self\_service\_password\_name | Desired IAM group name for the self service password. Default name is `self-service-password`. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| groups | List of groups which are managed by this module. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
