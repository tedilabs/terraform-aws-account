# iam-group

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
| name | Desired name for the IAM group. | `string` | n/a | yes |
| assumable\_roles | List of IAM roles ARNs which can be assumed by the group. | `list(string)` | `[]` | no |
| inline\_policies | Map of inline IAM policies to attach to IAM group. (`name` => `policy`). | `map(string)` | `{}` | no |
| path | Desired path for the IAM group. | `string` | `"/"` | no |
| policies | List of IAM policies ARNs to attach to IAM group. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN assigned by AWS for this group. |
| assumable\_roles | List of ARNs of IAM roles which members of IAM group can assume. |
| inline\_policies | List of names of inline IAM polices which are attached to IAM group. |
| name | IAM group name. |
| policies | List of ARNs of IAM policies which are atached to IAM group. |
| unique\_id | The unique ID assigned by AWS. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
