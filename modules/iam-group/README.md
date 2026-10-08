# iam-group

This module creates following resources.

- `aws_iam_group`
- `aws_iam_group_policies_exclusive` (optional)
- `aws_iam_group_policy` (optional)
- `aws_iam_group_policy_attachment` (optional)
- `aws_iam_group_policy_attachments_exclusive` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.12 |
| <a name="requirement_telemetry"></a> [telemetry](#requirement\_telemetry) | >= 0.1.1 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.12 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_iam_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policies_exclusive.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policies_exclusive) | resource |
| [aws_iam_group_policy.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy) | resource |
| [aws_iam_group_policy.inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy) | resource |
| [aws_iam_group_policy_attachment.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachments_exclusive.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachments_exclusive) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | (Required) Desired name for the IAM group. | `string` | n/a | yes |
| <a name="input_assumable_roles"></a> [assumable\_roles](#input\_assumable\_roles) | (Optional) A set of IAM roles ARNs which can be assumed by the group. | `set(string)` | `[]` | no |
| <a name="input_exclusive_inline_policy_management_enabled"></a> [exclusive\_inline\_policy\_management\_enabled](#input\_exclusive\_inline\_policy\_management\_enabled) | (Optional) Whether to enable exclusive management for inline IAM policies of the IAM user. This includes removal of inline IAM policies which are not explicitly configured. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_exclusive_policy_management_enabled"></a> [exclusive\_policy\_management\_enabled](#input\_exclusive\_policy\_management\_enabled) | (Optional) Whether to enable exclusive management for managed IAM policies of the IAM group. This includes removal of managed IAM policies which are not explicitly configured. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_inline_policies"></a> [inline\_policies](#input\_inline\_policies) | (Optional) A map of inline IAM policies to attach to IAM group. The policy is a JSON document that you attach to an identity to specify what API actions you're allowing or denying for that identity, and under which conditions. Each key is the name of the policy, and the value is the policy document. | `map(string)` | `{}` | no |
| <a name="input_path"></a> [path](#input\_path) | (Optional) Desired path for the IAM group. Defaults to `/`. | `string` | `"/"` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | (Optional) A set of IAM policies ARNs to attach to IAM group. | `set(string)` | `[]` | no |
| <a name="input_telemetry"></a> [telemetry](#input\_telemetry) | (Optional) A configuration to collect telemetry data for the module. This is used to improve the module and its features. The data collected is anonymous and does not contain any sensitive information. The default configuration enables telemetry collection for machine, network, git, github, github actions, terraform, and toolchain. You can disable telemetry collection by setting `enabled` to `false`. `telemetry` block as defined below.<br/>    (Optional) `enabled` - Whether to enable telemetry collection. Default is `true`.<br/>    (Optional) `capture_machine` - Whether to capture machine information. Default is `true`.<br/>    (Optional) `capture_network` - Whether to capture network information. Default is `true`.<br/>    (Optional) `capture_git` - Whether to capture git information. Default is `true`.<br/>    (Optional) `capture_github` - Whether to capture GitHub information. Default is `true`.<br/>    (Optional) `capture_github_actions` - Whether to capture GitHub Actions information. Default is `true`.<br/>    (Optional) `capture_terraform` - Whether to capture Terraform information. Default is `true`.<br/>    (Optional) `capture_toolchain` - Whether to capture toolchain information. Default is `true`. | <pre>object({<br/>    enabled = optional(bool, true)<br/><br/>    capture_machine        = optional(bool, true)<br/>    capture_network        = optional(bool, true)<br/>    capture_git            = optional(bool, true)<br/>    capture_github         = optional(bool, true)<br/>    capture_github_actions = optional(bool, true)<br/>    capture_terraform      = optional(bool, true)<br/>    capture_toolchain      = optional(bool, true)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the IAM group. |
| <a name="output_assumable_roles"></a> [assumable\_roles](#output\_assumable\_roles) | A set of ARNs of IAM roles which members of IAM group can assume. |
| <a name="output_exclusive_inline_policy_management_enabled"></a> [exclusive\_inline\_policy\_management\_enabled](#output\_exclusive\_inline\_policy\_management\_enabled) | Whether exclusive inline policy management is enabled for the IAM group. |
| <a name="output_exclusive_policy_management_enabled"></a> [exclusive\_policy\_management\_enabled](#output\_exclusive\_policy\_management\_enabled) | Whether exclusive policy management is enabled for the IAM group. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IAM group. |
| <a name="output_inline_policies"></a> [inline\_policies](#output\_inline\_policies) | A set of names of inline IAM polices which are attached to IAM group. |
| <a name="output_name"></a> [name](#output\_name) | The IAM group name. |
| <a name="output_path"></a> [path](#output\_path) | The path of the IAM group. |
| <a name="output_policies"></a> [policies](#output\_policies) | A set of ARNs of IAM policies which are atached to IAM group. |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | The unique ID assigned by AWS. |
<!-- END_TF_DOCS -->
