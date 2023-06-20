# cost

This module creates following resources.

- `aws_ce_anomaly_monitor` (optional)
- `aws_ce_cost_allocation_tag` (optional)
- `aws_spot_datafeed_subscription` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.23.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ce_anomaly_monitor.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ce_anomaly_monitor) | resource |
| [aws_ce_cost_allocation_tag.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ce_cost_allocation_tag) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocation_tags"></a> [allocation\_tags](#input\_allocation\_tags) | (Optional) A set of Cost Allocation Tags to activate. | `set(string)` | `[]` | no |
| <a name="input_anomaly_detection_monitors"></a> [anomaly\_detection\_monitors](#input\_anomaly\_detection\_monitors) | (Optional) A list of cost anomaly detection monitors to create.The provider of SSL certificate for the distribution. Valid values are `CLOUDFRONT`, `ACM` or `IAM`. Defaults to `CLOUDFRONT`. Each value of `anomaly_detection_monitors` as defined below.<br>    (Required) `name` - The name of the monitor.<br>    (Optional) `type` - The type of the monitor. Valid values are `CUSTOM` and `DIMENSIONAL`. Defaults to `CUSTOM`.<br>    (Optional) `dimension` - The dimension of the monitor to evaluate. Valid values are `SERVICE`. Defaults to `SERVICE`. Only required if monitor type is `DIMENSIONAL`.<br>    (Optional) `specification - The specification for custom-type monitor. A valid JSON representation for the Expression object. Only required if monitor type is `CUSTOM`.<br>` | <pre>list(object({<br>    name          = string<br>    type          = optional(string, "CUSTOM")<br>    dimension     = optional(string, "SERVICE")<br>    specification = optional(string, "")<br>  }))</pre> | `[]` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allocation_tags"></a> [allocation\_tags](#output\_allocation\_tags) | A set of activated Cost Allocation Tags. |
| <a name="output_anomaly_detection"></a> [anomaly\_detection](#output\_anomaly\_detection) | The configuration for the cost anomaly detection.<br>    `monitors` - A list of cost anomaly detection monitors.<br>    `subscriptions` - A list of cost anomaly detection subscriptions. |
| <a name="output_zzz"></a> [zzz](#output\_zzz) | output "password\_policy" { description = "Password Policy for the AWS Account. `expire_passwords` indicates whether passwords in the account expire. Returns `true` if `max_password_age` contains a value greater than 0." value       = aws\_iam\_account\_password\_policy.this }  output "billing\_contact" { description = "The billing contact attached to an AWS Account." value = try({ name  = aws\_account\_alternate\_contact.billing[0].name title = aws\_account\_alternate\_contact.billing[0].title email = aws\_account\_alternate\_contact.billing[0].email\_address phone = aws\_account\_alternate\_contact.billing[0].phone\_number }, null) }  output "operation\_contact" { description = "The operation contact attached to an AWS Account." value = try({ name  = aws\_account\_alternate\_contact.operation[0].name title = aws\_account\_alternate\_contact.operation[0].title email = aws\_account\_alternate\_contact.operation[0].email\_address phone = aws\_account\_alternate\_contact.operation[0].phone\_number }, null) }  output "security\_contact" { description = "The security contact attached to an AWS Account." value = try({ name  = aws\_account\_alternate\_contact.security[0].name title = aws\_account\_alternate\_contact.security[0].title email = aws\_account\_alternate\_contact.security[0].email\_address phone = aws\_account\_alternate\_contact.security[0].phone\_number }, null) }  output "ec2" { description = <<EOF The account-level configurations of EC2 service. `spot_datafeed_subscription` - To help you understand the charges for your Spot instances, Amazon EC2 provides a data feed that describes your Spot instance usage and pricing. This data feed is sent to an Amazon S3 bucket that you specify when you subscribe to the data feed. EOF value = { spot\_datafeed\_subscription = { enabled = var.ec2\_spot\_datafeed\_subscription\_enabled s3 = { bucket = one(aws\_spot\_datafeed\_subscription.this[*].bucket) prefix = one(aws\_spot\_datafeed\_subscription.this[*].prefix) } } } } |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
