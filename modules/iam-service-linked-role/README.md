# iam-service-linked-role

This module creates following resources.

- `aws_iam_service_linked_role`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.12.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_service_linked_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_service"></a> [aws\_service](#input\_aws\_service) | (Required) The AWS service principal to which this role is attached. For example: `elasticbeanstalk.amazonaws.com`. | `string` | n/a | yes |
| <a name="input_custom_suffix"></a> [custom\_suffix](#input\_custom\_suffix) | (Optional) Additional string appended to the role name. Not all AWS services support custom suffixes. | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the role. Defaults to `Managed by Terraform.`. | `string` | `"Managed by Terraform."` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN assigned by AWS for this role. |
| <a name="output_aws_service"></a> [aws\_service](#output\_aws\_service) | The AWS service principal to which this role is attached. |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The creation date of the IAM role. |
| <a name="output_description"></a> [description](#output\_description) | The description of the role. |
| <a name="output_name"></a> [name](#output\_name) | IAM Role name. |
| <a name="output_path"></a> [path](#output\_path) | The path of the role. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | The unique ID assigned by AWS. |
<!-- END_TF_DOCS -->
