# account

This module creates following resources.

- `aws_iam_account_alias`
- `aws_iam_account_password_policy`
- `aws_account_alternate_contact` (optional)
- `aws_s3_account_public_access_block`
- `aws_spot_datafeed_subscription` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.19 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_account_alternate_contact.billing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_alternate_contact.operation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_alternate_contact.security](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_iam_account_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_alias) | resource |
| [aws_iam_account_password_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |
| [aws_s3_account_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_account_public_access_block) | resource |
| [aws_spot_datafeed_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/spot_datafeed_subscription) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name for the AWS account. Used for the account alias. | `string` | n/a | yes |
| <a name="input_billing_contact"></a> [billing\_contact](#input\_billing\_contact) | (Optional) Billing Contact for the AWS Account. | `map(string)` | `null` | no |
| <a name="input_ec2_spot_datafeed_subscription_enabled"></a> [ec2\_spot\_datafeed\_subscription\_enabled](#input\_ec2\_spot\_datafeed\_subscription\_enabled) | (Optional) Indicates whether to enable Spot Data Feed Subscription to S3 Bucket. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_ec2_spot_datafeed_subscription_s3_bucket"></a> [ec2\_spot\_datafeed\_subscription\_s3\_bucket](#input\_ec2\_spot\_datafeed\_subscription\_s3\_bucket) | (Optional) The name of the S3 bucket to deliver Spot Data Feed to. | `string` | `""` | no |
| <a name="input_ec2_spot_datafeed_subscription_s3_prefix"></a> [ec2\_spot\_datafeed\_subscription\_s3\_prefix](#input\_ec2\_spot\_datafeed\_subscription\_s3\_prefix) | (Optional) The path of directory inside S3 bucket to place spot pricing data. | `string` | `""` | no |
| <a name="input_operation_contact"></a> [operation\_contact](#input\_operation\_contact) | (Optional) Operation Contact for the AWS Account. | `map(string)` | `null` | no |
| <a name="input_password_policy"></a> [password\_policy](#input\_password\_policy) | (Optional) Password Policy for the AWS account. | <pre>object({<br>    minimum_password_length        = number<br>    require_numbers                = bool<br>    require_symbols                = bool<br>    require_lowercase_characters   = bool<br>    require_uppercase_characters   = bool<br>    allow_users_to_change_password = bool<br>    hard_expiry                    = bool<br>    max_password_age               = number<br>    password_reuse_prevention      = number<br>  })</pre> | <pre>{<br>  "allow_users_to_change_password": true,<br>  "hard_expiry": false,<br>  "max_password_age": 0,<br>  "minimum_password_length": 8,<br>  "password_reuse_prevention": 0,<br>  "require_lowercase_characters": true,<br>  "require_numbers": true,<br>  "require_symbols": true,<br>  "require_uppercase_characters": true<br>}</pre> | no |
| <a name="input_s3_public_access_enabled"></a> [s3\_public\_access\_enabled](#input\_s3\_public\_access\_enabled) | (Optional) Whether to enable S3 account-level Public Access Block configuration. Block the public access to S3 bucket if the value is `false`. | `bool` | `false` | no |
| <a name="input_security_contact"></a> [security\_contact](#input\_security\_contact) | (Optional) Security Contact for the AWS Account. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_billing_contact"></a> [billing\_contact](#output\_billing\_contact) | The billing contact attached to an AWS Account. |
| <a name="output_ec2"></a> [ec2](#output\_ec2) | The account-level configurations of EC2 service.<br>    `spot_datafeed_subscription` - To help you understand the charges for your Spot instances, Amazon EC2 provides a data feed that describes your Spot instance usage and pricing. This data feed is sent to an Amazon S3 bucket that you specify when you subscribe to the data feed. |
| <a name="output_id"></a> [id](#output\_id) | The AWS Account ID. |
| <a name="output_name"></a> [name](#output\_name) | Name of the AWS account. The account alias. |
| <a name="output_operation_contact"></a> [operation\_contact](#output\_operation\_contact) | The operation contact attached to an AWS Account. |
| <a name="output_password_policy"></a> [password\_policy](#output\_password\_policy) | Password Policy for the AWS Account. `expire_passwords` indicates whether passwords in the account expire. Returns `true` if `max_password_age` contains a value greater than 0. |
| <a name="output_s3"></a> [s3](#output\_s3) | The account-level configurations of S3 service.<br>    `public_access_enabled` - Whether to enable S3 account-level Public Access Block configuration. |
| <a name="output_security_contact"></a> [security\_contact](#output\_security\_contact) | The security contact attached to an AWS Account. |
| <a name="output_signin_url"></a> [signin\_url](#output\_signin\_url) | The URL to signin for the AWS account. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
