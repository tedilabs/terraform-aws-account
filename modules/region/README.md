# region

This module creates following resources.

- `aws_ebs_encryption_by_default`
- `aws_ebs_default_kms_key` (optional)
- `aws_ec2_image_block_public_access`
- `aws_ec2_instance_metadata_defaults`
- `aws_ec2_serial_console_access`
- `aws_inspector2_delegated_admin_account` (optional)
- `aws_macie2_organization_admin_account` (optional)
- `aws_resourceexplorer2_index` (optional)
- `aws_resourceexplorer2_view` (optional)
- `aws_servicequotas_service_quota` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.43 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.48.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ebs_default_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_default_kms_key) | resource |
| [aws_ebs_encryption_by_default.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default) | resource |
| [aws_ec2_availability_zone_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_availability_zone_group) | resource |
| [aws_ec2_image_block_public_access.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_image_block_public_access) | resource |
| [aws_ec2_instance_metadata_defaults.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_instance_metadata_defaults) | resource |
| [aws_ec2_serial_console_access.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_serial_console_access) | resource |
| [aws_inspector2_delegated_admin_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_delegated_admin_account) | resource |
| [aws_macie2_organization_admin_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/macie2_organization_admin_account) | resource |
| [aws_resourceexplorer2_index.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourceexplorer2_index) | resource |
| [aws_resourceexplorer2_view.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourceexplorer2_view) | resource |
| [aws_servicequotas_service_quota.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/servicequotas_service_quota) | resource |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ebs_default_encryption"></a> [ebs\_default\_encryption](#input\_ebs\_default\_encryption) | (Optional) The configuration of the EBS default encryption. `ebs_default_encryption` as defined below.<br>    (Optional) `enabled` - Whether or not default EBS encryption is enabled.<br>    (Optional) `kms_key` - The ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use to encrypt the EBS volume. | <pre>object({<br>    enabled = optional(bool, false)<br>    kms_key = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_ec2"></a> [ec2](#input\_ec2) | (Optional) The configuration of EC2 in the current AWS region. `ec2` as defined below.<br>    (Optional) `ami_public_access_enabled` - Whether to allow or block public access for AMIs at the account level to prevent the public sharing of your AMIs in this region. Defaults to `false`.<br>    (Optional) `instance_metadata_defaults` - The configuration of the regional instance metadata default settings. `instance_metadata_defaults` as defined below.<br>      (Optional) `http_enabled` - Whether to enable or disable the HTTP metadata endpoint on your instances. Defaults to `null` (No preference).<br>      (Optional) `http_token_required` - Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2 (IMDSv2). Defaults to `false`. Defaults to `null` (No preference).<br>      (Optional) `http_put_response_hop_limit` - A desired HTTP PUT response hop limit for instance metadata requests. The larger the number, the further instance metadata requests can travel. Valid values are integer from `1` to `64`. Defaults to `null` (No preference).<br>      (Optional) `instance_tags_enabled` - Whether to enable the access to instance tags from the instance metadata service. Defaults to `null` (No preference).<br>    (Optional) `serial_console_enabled` - Whether serial console access is enabled for the current AWS region. Defaults to `false`. | <pre>object({<br>    ami_public_access_enabled = optional(bool, false)<br>    instance_metadata_defaults = optional(object({<br>      http_enabled                = optional(bool)<br>      http_token_required         = optional(bool)<br>      http_put_response_hop_limit = optional(number)<br>      instance_tags_enabled       = optional(bool)<br>    }), {})<br>    serial_console_enabled = optional(bool, false)<br>  })</pre> | `{}` | no |
| <a name="input_inspector"></a> [inspector](#input\_inspector) | (Optional) The configuration of Inspector in the current AWS region. `inspector` as defined below.<br>    (Optional) `delegated_administrator` - The AWS account ID for the account to designate as the delegated Amazon Inspector administrator account for the organization. The delegated administrator is granted all of the permissions required to administer Inspector for your organization. When you choose a delegated administrator, Inspector is activated for that account. Can be used in only management account of the organization. | <pre>object({<br>    delegated_administrator = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_macie"></a> [macie](#input\_macie) | (Optional) The configuration of Macie in the current AWS region. `macie` as defined below.<br>    (Optional) `delegated_administrator` - The AWS account ID for the account to designate as the delegated Amazon Macie administrator account for the organization. This can be configured only if Macie is enabled for the organization. The account must be a management account of the organization. | <pre>object({<br>    delegated_administrator = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_explorer"></a> [resource\_explorer](#input\_resource\_explorer) | (Optional) The configuration of the Resource Explorer in the current AWS region. `resource_explorer` as defined below.<br>    (Optional) `enabled` - Whether or not to enable the Resource Explorer in the current AWS region. Defaults to `true`.<br>    (Optional) `index_type` - The type of the index. Valid values are `AGGREGATOR`, `LOCAL`. Defaults to `LOCAL`.<br>    (Optional) `views` - A list of views to create. `views` as defined below.<br>      (Required) `name` - The name of the view. The name must be no more than 64 characters long, and can include letters, digits, and the dash (-) character. The name must be unique within its AWS Region.<br>      (Optional) `is_default` - Whether the view is the default view for the AWS Region. Defaults to `false`.<br>      (Optional) `filter_queries` - A list of filter queries. Specify which resources are included in the results of queries made using this view. The filter string is combined using a logical AND operator. Defaults to `[]` (include all resources).<br>      (Optional) `additional_resource_attributes` - A list of additional resource attributes. By default, the results include ARN, owner account, Region, service, and resource type. Valid values are `tags`. Defaults to `[]`. | <pre>object({<br>    enabled    = optional(bool, true)<br>    index_type = optional(string, "LOCAL")<br>    views = optional(list(object({<br>      name           = string<br>      is_default     = optional(bool, false)<br>      filter_queries = optional(list(string), [])<br><br>      additional_resource_attributes = optional(set(string), [])<br>    })), [])<br>  })</pre> | `{}` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Groupolicy. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Groupolicy. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_service_quotas_code_translation_enabled"></a> [service\_quotas\_code\_translation\_enabled](#input\_service\_quotas\_code\_translation\_enabled) | (Optional) Whether to use translated quota code for readability. | `bool` | `false` | no |
| <a name="input_service_quotas_request"></a> [service\_quotas\_request](#input\_service\_quotas\_request) | (Optional) A map of service quotas to request. The key is `<service-code>/<quota-code>` and the value is a desired value to request. | `map(number)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_availability_zone_groups"></a> [vpc\_availability\_zone\_groups](#input\_vpc\_availability\_zone\_groups) | (Optional) The configurations to manage Availability Zone Groups for the current AWS region. The key is the name of Availability Zone Group, the value is a boolean value to enable the group. In this time, disabling Availability Zone Group is not supported on AWS. | `map(bool)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_code"></a> [code](#output\_code) | The short code of the current region. |
| <a name="output_description"></a> [description](#output\_description) | The description of the current region in this format: `Location (Region name)` |
| <a name="output_ebs"></a> [ebs](#output\_ebs) | The region-level configurations of EBS service.<br>    `default_encryption` - The configurations for EBS Default Encryption. |
| <a name="output_ec2"></a> [ec2](#output\_ec2) | The region-level configurations of EC2 service.<br>    `ami_public_access_enabled` - Whether to allow or block public access for AMIs at the account level to prevent the public sharing of your AMIs in this region.<br>    `serial_console_enabled` - Whether serial console access is enabled for the current AWS region. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the current region. |
| <a name="output_inspector"></a> [inspector](#output\_inspector) | The region-level configurations of Inspector service.<br>    `delegated_administrator` - The AWS account ID for the account to designate as the delegated Amazon Inspector administrator account for the organization. |
| <a name="output_macie"></a> [macie](#output\_macie) | The region-level configurations of Macie service.<br>    `delegated_administrator` - The AWS account ID for the account to designate as the delegated Amazon Macie administrator account for the organization. |
| <a name="output_name"></a> [name](#output\_name) | The name of the current region. |
| <a name="output_resource_explorer"></a> [resource\_explorer](#output\_resource\_explorer) | The region-level configurations of Resource Explorer service.<br>    `enabled` - Whether the Resource Explorer is enabled in the current AWS region.<br>    `index_type` - The type of the index.<br>    `views` - The list of views. |
| <a name="output_service_quotas"></a> [service\_quotas](#output\_service\_quotas) | The region-level configurations of Service Quotas. |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | The region-level configurations of VPC. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
