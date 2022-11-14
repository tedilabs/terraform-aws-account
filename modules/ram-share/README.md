# ram-share

This module creates following resources.

- `aws_ram_resource_share`
- `aws_ram_principal_association` (optional)
- `aws_ram_resource_association` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.29 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.39.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ram_principal_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the resource share. | `string` | n/a | yes |
| <a name="input_external_principals_allowed"></a> [external\_principals\_allowed](#input\_external\_principals\_allowed) | (Optional) Indicates whether principals outside your organization can be associated with a resource share. | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | (Optional) A list of the names of the RAM permission to associate with the resource share. If you do not specify, RAM automatically attaches the default version of the permission for each resource type. You can associate only one permission with each resource type included in the resource share. | `list(string)` | `[]` | no |
| <a name="input_principals"></a> [principals](#input\_principals) | (Optional) A list of the Amazon Resource Names (ARNs) of the principal to associate with the RAM Resource Share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN. | `list(string)` | `[]` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_resources"></a> [resources](#input\_resources) | (Optional) A list of the Amazon Resource Names (ARNs) of the resource to associate with the RAM Resource Share. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the resource share. |
| <a name="output_external_principals_allowed"></a> [external\_principals\_allowed](#output\_external\_principals\_allowed) | Whether principals outside your organization can be associated with a resource share. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the resource share. |
| <a name="output_name"></a> [name](#output\_name) | The name of the resource share. |
| <a name="output_permissions"></a> [permissions](#output\_permissions) | A list of the Amazon Resource Names (ARNs) of the RAM permission associated with the resource share. |
| <a name="output_principals"></a> [principals](#output\_principals) | A list of the Amazon Resource Names (ARNs) of the principal associated with the resource share. |
| <a name="output_resources"></a> [resources](#output\_resources) | A list of the Amazon Resource Names (ARNs) of the resource associated with the resource share. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
