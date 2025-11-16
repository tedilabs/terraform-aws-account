# region

This module creates following resources.

- `aws_ebs_encryption_by_default`
- `aws_ebs_default_kms_key` (optional)
- `aws_ec2_availability_zone_group` (optional)
- `aws_ec2_image_block_public_access`
- `aws_ec2_instance_metadata_defaults` (optional)
- `aws_ec2_serial_console_access`
- `aws_oam_sink` (optional)
- `aws_oam_sink_policy` (optional)
- `aws_resourceexplorer2_index` (optional)
- `aws_resourceexplorer2_view` (optional)
- `aws_servicequotas_service_quota` (optional)
- `aws_sesv2_account_suppression_attributes` (optional)
- `aws_vpc_block_public_access_options` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.21 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.21.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch_oam_sink"></a> [cloudwatch\_oam\_sink](#module\_cloudwatch\_oam\_sink) | tedilabs/observability/aws//modules/cloudwatch-oam-sink | ~> 0.2.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ebs_default_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_default_kms_key) | resource |
| [aws_ebs_encryption_by_default.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default) | resource |
| [aws_ebs_snapshot_block_public_access.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_snapshot_block_public_access) | resource |
| [aws_ec2_availability_zone_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_availability_zone_group) | resource |
| [aws_ec2_image_block_public_access.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_image_block_public_access) | resource |
| [aws_ec2_instance_metadata_defaults.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_instance_metadata_defaults) | resource |
| [aws_ec2_serial_console_access.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_serial_console_access) | resource |
| [aws_resourceexplorer2_index.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourceexplorer2_index) | resource |
| [aws_resourceexplorer2_view.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourceexplorer2_view) | resource |
| [aws_servicequotas_service_quota.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/servicequotas_service_quota) | resource |
| [aws_sesv2_account_suppression_attributes.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sesv2_account_suppression_attributes) | resource |
| [aws_vpc_block_public_access_options.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_block_public_access_options) | resource |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch"></a> [cloudwatch](#input\_cloudwatch) | (Optional) The configuration of CloudWatch in the current AWS region. `cloudwatch` as defined below.<br/>    (Optional) `oam_sink` - A configuration of CloudWatch OAM(Observability Access Manager) sink. `oam_sink` as defined below.<br/>      (Required) `name` - The name of the CloudWatch OAM sink.<br/>      (Optional) `telemetry_types` - A set of the telemetry types can be shared with it. Valid values are `AWS::CloudWatch::Metric`, `AWS::Logs::LogGroup`, `AWS::XRay::Trace`, `AWS::ApplicationInsights::Application`, `AWS::InternetMonitor::Monitor`.<br/>      (Optional) `allowed_source_accounts` - A list of the IDs of AWS accounts that will share data with this monitoring account.<br/>      (Optional) `allowed_source_organizations` - A list of the organization IDs of AWS accounts that will share data with this monitoring account.<br/>      (Optional) `allowed_source_organization_paths` - A list of the organization paths of the AWS accounts that will share data with this monitoring account.<br/>      (Optional) `tags` - A map of tags to add to the resource. | <pre>object({<br/>    oam_sink = optional(object({<br/>      name                              = string<br/>      telemetry_types                   = optional(set(string), [])<br/>      allowed_source_accounts           = optional(list(string), [])<br/>      allowed_source_organizations      = optional(list(string), [])<br/>      allowed_source_organization_paths = optional(list(string), [])<br/>      tags                              = optional(map(string), {})<br/>    }))<br/>  })</pre> | `{}` | no |
| <a name="input_ebs"></a> [ebs](#input\_ebs) | (Optional) The configuration of EBS in the current AWS region. `ebs` as defined below.<br/>    (Optional) `default_encryption` - The configuration of the EBS default encryption. `default_encryption` as defined below.<br/>      (Optional) `enabled` - Whether or not default EBS encryption is enabled.<br/>      (Optional) `kms_key` - The ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use to encrypt the EBS volume.<br/>    (Optional) `snapshot_public_access_mode` - The mode in which to enable "Block public access for snapshots" for the region. Valid values are `block-all-sharing`, `block-new-sharing`, `unblocked`. Defaults to `block-new-sharing`. | <pre>object({<br/>    default_encryption = optional(object({<br/>      enabled = optional(bool, false)<br/>      kms_key = optional(string)<br/>    }), {})<br/>    snapshot_public_access_mode = optional(string, "block-new-sharing")<br/>  })</pre> | `{}` | no |
| <a name="input_ec2"></a> [ec2](#input\_ec2) | (Optional) The configuration of EC2 in the current AWS region. `ec2` as defined below.<br/>    (Optional) `ami_public_access_mode` - The mode of block public access for AMIs at the account level in the configured AWS Region. Valid values are `block-new-sharing`, `unblocked`. Defaults to `block-new-sharing`.<br/>    (Optional) `instance_metadata_defaults` - The configuration of the regional instance metadata default settings. `instance_metadata_defaults` as defined below.<br/>      (Optional) `http_enabled` - Whether to enable or disable the HTTP metadata endpoint on your instances. Defaults to `null` (No preference).<br/>      (Optional) `http_token_required` - Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2 (IMDSv2). Defaults to `false`. Defaults to `null` (No preference).<br/>      (Optional) `http_put_response_hop_limit` - A desired HTTP PUT response hop limit for instance metadata requests. The larger the number, the further instance metadata requests can travel. Valid values are integer from `1` to `64`. Defaults to `null` (No preference).<br/>      (Optional) `instance_tags_enabled` - Whether to enable the access to instance tags from the instance metadata service. Defaults to `null` (No preference).<br/>    (Optional) `serial_console_enabled` - Whether serial console access is enabled for the current AWS region. Defaults to `false`. | <pre>object({<br/>    ami_public_access_mode = optional(string, "block-new-sharing")<br/>    instance_metadata_defaults = optional(object({<br/>      http_enabled                = optional(bool)<br/>      http_token_required         = optional(bool)<br/>      http_put_response_hop_limit = optional(number)<br/>      instance_tags_enabled       = optional(bool)<br/>    }), {})<br/>    serial_console_enabled = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region. | `string` | `null` | no |
| <a name="input_resource_explorer"></a> [resource\_explorer](#input\_resource\_explorer) | (Optional) The configuration of the Resource Explorer in the current AWS region. `resource_explorer` as defined below.<br/>    (Optional) `enabled` - Whether or not to enable the Resource Explorer in the current AWS region. Defaults to `true`.<br/>    (Optional) `index_type` - The type of the index. Valid values are `AGGREGATOR`, `LOCAL`. Defaults to `LOCAL`.<br/>    (Optional) `views` - A list of views to create. `views` as defined below.<br/>      (Required) `name` - The name of the view. The name must be no more than 64 characters long, and can include letters, digits, and the dash (-) character. The name must be unique within its AWS Region.<br/>      (Optional) `is_default` - Whether the view is the default view for the AWS Region. Defaults to `false`.<br/>      (Optional) `scope` - The root ARN of the account, an organizational unit (OU), or an organization ARN. Defaults to the account.<br/>      (Optional) `filter_queries` - A list of filter queries. Specify which resources are included in the results of queries made using this view. The filter string is combined using a logical AND operator. Defaults to `[]` (include all resources).<br/>      (Optional) `additional_resource_attributes` - A list of additional resource attributes. By default, the results include ARN, owner account, Region, service, and resource type. Valid values are `tags`. Defaults to `[]`. | <pre>object({<br/>    enabled    = optional(bool, true)<br/>    index_type = optional(string, "LOCAL")<br/>    views = optional(list(object({<br/>      name           = string<br/>      is_default     = optional(bool, false)<br/>      scope          = optional(string)<br/>      filter_queries = optional(list(string), [])<br/><br/>      additional_resource_attributes = optional(set(string), [])<br/>    })), [])<br/>  })</pre> | `{}` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_service_quotas"></a> [service\_quotas](#input\_service\_quotas) | (Optional) The configuration of Service Quotas in the current AWS region. `service_quotas` as defined below.<br/>    (Optional) `requests` - A map of service quotas to request. The key is `<service-code>/<quota-code>` and the value is a desired value to request.<br/>    (Optional) `code_translation_enabled` - Whether to use translated quota code for readability. Defaults to `false`. | <pre>object({<br/>    requests                 = optional(map(number), {})<br/>    code_translation_enabled = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_ses"></a> [ses](#input\_ses) | (Optional) The configuration of the SES (Simple Email Service) for the account. `ses` as defined below.<br/>    (Optional) `suppression_reasons` - A set of the reasons that email addresses will be automatically added to the suppression list for your account. Valid values are `COMPLAINT`, `BOUNCE`. | <pre>object({<br/>    suppression_reasons = optional(set(string), ["COMPLAINT", "BOUNCE"])<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | (Optional) The configuration of VPC in the current AWS region. `vpc` as defined below.<br/>    (Optional) `availability_zone_groups` - A map of Availability Zone Groups to manage for the current AWS region. The key is the name of Availability Zone Group, the value is a boolean value to enable the group. In this time, disabling Availability Zone Group is not supported on AWS.<br/>    (Optional) `block_public_access_mode` - The mode in which to enable "Block Public Access" for the VPC in the current AWS region. Valid values are `BIDIRECTIONAL`, `INGRESS`, `OFF`. Defaults to `OFF`. | <pre>object({<br/>    availability_zone_groups = optional(map(bool), {})<br/>    block_public_access_mode = optional(string, "OFF")<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwdatch"></a> [cloudwdatch](#output\_cloudwdatch) | The region-level configurations of CloudWatch service.<br/>    `oam_sink` - A configuration of CloudWatch OAM(Observability Access Manager) sink. |
| <a name="output_code"></a> [code](#output\_code) | The short code of the current region. |
| <a name="output_description"></a> [description](#output\_description) | The description of the current region in this format: `Location (Region name)` |
| <a name="output_ebs"></a> [ebs](#output\_ebs) | The region-level configurations of EBS service.<br/>    `default_encryption` - The configurations for EBS Default Encryption. |
| <a name="output_ec2"></a> [ec2](#output\_ec2) | The region-level configurations of EC2 service.<br/>    `ami_public_access_enabled` - Whether to allow or block public access for AMIs at the account level to prevent the public sharing of your AMIs in this region.<br/>    `serial_console_enabled` - Whether serial console access is enabled for the current AWS region. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the current region. |
| <a name="output_name"></a> [name](#output\_name) | The name of the current region. |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this module resources resides in. |
| <a name="output_resource_explorer"></a> [resource\_explorer](#output\_resource\_explorer) | The region-level configurations of Resource Explorer service.<br/>    `enabled` - Whether the Resource Explorer is enabled in the current AWS region.<br/>    `index_type` - The type of the index.<br/>    `views` - The list of views. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_service_quotas"></a> [service\_quotas](#output\_service\_quotas) | The region-level configurations of Service Quotas. |
| <a name="output_ses"></a> [ses](#output\_ses) | The region-level configurations of SES service.<br/>    `suppression_reasons` - A set of the reasons that email addresses will be automatically added to the suppression list for your account. |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | The region-level configurations of VPC. |
<!-- END_TF_DOCS -->
