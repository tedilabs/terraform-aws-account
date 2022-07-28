# iam-group

This module creates following resources.

- `aws_iam_group`
- `aws_iam_group_policy` (optional)
- `aws_iam_group_policy_attachment` (optional)

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
| [aws_iam_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy) | resource |
| [aws_iam_group_policy.inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy) | resource |
| [aws_iam_group_policy_attachment.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Desired name for the IAM group. | `string` | n/a | yes |
| <a name="input_assumable_roles"></a> [assumable\_roles](#input\_assumable\_roles) | List of IAM roles ARNs which can be assumed by the group. | `list(string)` | `[]` | no |
| <a name="input_inline_policies"></a> [inline\_policies](#input\_inline\_policies) | Map of inline IAM policies to attach to IAM group. (`name` => `policy`). | `map(string)` | `{}` | no |
| <a name="input_path"></a> [path](#input\_path) | Desired path for the IAM group. | `string` | `"/"` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | List of IAM policies ARNs to attach to IAM group. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN assigned by AWS for this group. |
| <a name="output_assumable_roles"></a> [assumable\_roles](#output\_assumable\_roles) | List of ARNs of IAM roles which members of IAM group can assume. |
| <a name="output_inline_policies"></a> [inline\_policies](#output\_inline\_policies) | List of names of inline IAM polices which are attached to IAM group. |
| <a name="output_name"></a> [name](#output\_name) | IAM group name. |
| <a name="output_policies"></a> [policies](#output\_policies) | List of ARNs of IAM policies which are atached to IAM group. |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | The unique ID assigned by AWS. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
