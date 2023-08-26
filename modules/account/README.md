# account

This module creates following resources.

- `aws_iam_account_alias`
- `aws_iam_account_password_policy`
- `aws_iam_security_token_service_preferences`
- `aws_account_primary_contact` (optional)
- `aws_account_alternate_contact` (optional)
- `aws_s3_account_public_access_block`
- `aws_spot_datafeed_subscription` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_account_alternate_contact.billing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_alternate_contact.operation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_alternate_contact.security](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_primary_contact.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_primary_contact) | resource |
| [aws_iam_account_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_alias) | resource |
| [aws_iam_account_password_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |
| [aws_iam_security_token_service_preferences.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_security_token_service_preferences) | resource |
| [aws_s3_account_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_account_public_access_block) | resource |
| [aws_spot_datafeed_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/spot_datafeed_subscription) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name for the AWS account. Used for the account alias. | `string` | n/a | yes |
| <a name="input_billing_contact"></a> [billing\_contact](#input\_billing\_contact) | (Optional) The configuration of the billing contact for the AWS Account. `billing_contact` as defined below.<br>    (Required) `name` - The name of the billing contact.<br>    (Optional) `title` - The tile of the billing contact. Defaults to `Billing Manager`.<br>    (Required) `email` - The email address of the billing contact.<br>    (Required) `phone` - The phone number of the billing contact. | <pre>object({<br>    name  = string<br>    title = optional(string, "Billing Manager")<br>    email = string<br>    phone = string<br>  })</pre> | `null` | no |
| <a name="input_ec2_spot_datafeed_subscription"></a> [ec2\_spot\_datafeed\_subscription](#input\_ec2\_spot\_datafeed\_subscription) | (Optional) The configuration of the Spot Data Feed Subscription. `ec2_spot_datafeed_subscription` as defined below.<br>    (Optional) `enabled` - Indicate whether to enable Spot Data Feed Subscription to S3 Bucket. Defaults to `false`.<br>    (Optional) `s3_bucket` - The configuration of the S3 bucket where AWS deliver the spot data feed. `s3_bucket` as defined below.<br>      (Required) `name` - The name of the S3 bucket where AWS deliver the spot data feed.<br>      (Optional) `key_prefix` - The path of directory inside S3 bucket to place spot pricing data. | <pre>object({<br>    enabled = optional(bool, false)<br>    s3_bucket = optional(object({<br>      name       = optional(string, "")<br>      key_prefix = optional(string, "")<br>    }))<br>  })</pre> | `{}` | no |
| <a name="input_operation_contact"></a> [operation\_contact](#input\_operation\_contact) | (Optional) The configuration of the operation contact for the AWS Account. `operation_contact` as defined below.<br>    (Required) `name` - The name of the operation contact.<br>    (Optional) `title` - The tile of the operation contact. Defaults to `Operation Manager`.<br>    (Required) `email` - The email address of the operation contact.<br>    (Required) `phone` - The phone number of the operation contact. | <pre>object({<br>    name  = string<br>    title = optional(string, "Operation Manager")<br>    email = string<br>    phone = string<br>  })</pre> | `null` | no |
| <a name="input_password_policy"></a> [password\_policy](#input\_password\_policy) | (Optional) Password Policy for the AWS account. | <pre>object({<br>    minimum_password_length        = optional(number, 8)<br>    require_numbers                = optional(bool, true)<br>    require_symbols                = optional(bool, true)<br>    require_lowercase_characters   = optional(bool, true)<br>    require_uppercase_characters   = optional(bool, true)<br>    allow_users_to_change_password = optional(bool, true)<br>    hard_expiry                    = optional(bool, false)<br>    max_password_age               = optional(number, 0)<br>    password_reuse_prevention      = optional(number, 0)<br>  })</pre> | `{}` | no |
| <a name="input_primary_contact"></a> [primary\_contact](#input\_primary\_contact) | (Optional) The configuration of the primary contact for the AWS Account. `primary_contact` as defined below.<br>    (Required) `name` - The full name of the primary contact address.<br>    (Optional) `company_name` - The name of the company associated with the primary contact information, if any.<br>    (Required) `country_code` - The ISO-3166 two-letter country code for the primary contact address.<br>    (Optional) `state` - The state or region of the primary contact address. This field is required in selected countries.<br>    (Required) `city` - The city of the primary contact address.<br>    (Optional) `district` - The district or county of the primary contact address, if any.<br>    (Required) `address_line_1` - The first line of the primary contact address.<br>    (Optional) `address_line_2` - The second line of the primary contact address, if any.<br>    (Optional) `address_line_3` - The third line of the primary contact address, if any.<br>    (Required) `postal_code` - The postal code of the primary contact address.<br>    (Required) `phone` - The phone number of the primary contact information. The number will be validated and, in some countries, checked for activation.<br>    (Optional) `website_url` -  The URL of the website associated with the primary contact information, if any. | <pre>object({<br>    name           = string<br>    company_name   = optional(string)<br>    country_code   = string<br>    state          = optional(string)<br>    city           = string<br>    district       = optional(string)<br>    address_line_1 = string<br>    address_line_2 = optional(string)<br>    address_line_3 = optional(string)<br>    postal_code    = string<br>    phone          = string<br>    website_url    = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_s3_public_access_enabled"></a> [s3\_public\_access\_enabled](#input\_s3\_public\_access\_enabled) | (Optional) Whether to enable S3 account-level Public Access Block configuration. Block the public access to S3 bucket if the value is `false`. | `bool` | `false` | no |
| <a name="input_security_contact"></a> [security\_contact](#input\_security\_contact) | (Optional) The configuration of the security contact for the AWS Account. `security_contact` as defined below.<br>    (Required) `name` - The name of the security contact.<br>    (Optional) `title` - The tile of the security contact. Defaults to `Security Manager`.<br>    (Required) `email` - The email address of the security contact.<br>    (Required) `phone` - The phone number of the security contact. | <pre>object({<br>    name  = string<br>    title = optional(string, "Security Manager")<br>    email = string<br>    phone = string<br>  })</pre> | `null` | no |
| <a name="input_sts_global_endpoint_token_version"></a> [sts\_global\_endpoint\_token\_version](#input\_sts\_global\_endpoint\_token\_version) | (Optional) The version of the STS global endpoint token. Valid values are `v1` and<br>  `v2`. Defaults to `v1`.<br>    `v1` - Version 1 Tokens are valid only in AWS Regions that are available by default. These tokens do not work in manually enabled Regions, such as Asia Pacific (Hong Kong).<br>    `v2` - Version 2 tokens are valid in all Regions. However, version 2 tokens include more characters and might affect systems where you temporarily store tokens. | `string` | `"v1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_billing_contact"></a> [billing\_contact](#output\_billing\_contact) | The billing contact attached to an AWS Account. |
| <a name="output_ec2"></a> [ec2](#output\_ec2) | The account-level configurations of EC2 service.<br>    `spot_datafeed_subscription` - To help you understand the charges for your Spot instances, Amazon EC2 provides a data feed that describes your Spot instance usage and pricing. This data feed is sent to an Amazon S3 bucket that you specify when you subscribe to the data feed. |
| <a name="output_id"></a> [id](#output\_id) | The AWS Account ID. |
| <a name="output_name"></a> [name](#output\_name) | Name of the AWS account. The account alias. |
| <a name="output_operation_contact"></a> [operation\_contact](#output\_operation\_contact) | The operation contact attached to an AWS Account. |
| <a name="output_password_policy"></a> [password\_policy](#output\_password\_policy) | Password Policy for the AWS Account. `expire_passwords` indicates whether passwords in the account expire. Returns `true` if `max_password_age` contains a value greater than 0. |
| <a name="output_primary_contact"></a> [primary\_contact](#output\_primary\_contact) | The primary contact attached to an AWS Account. |
| <a name="output_s3"></a> [s3](#output\_s3) | The account-level configurations of S3 service.<br>    `public_access_enabled` - Whether to enable S3 account-level Public Access Block configuration. |
| <a name="output_security_contact"></a> [security\_contact](#output\_security\_contact) | The security contact attached to an AWS Account. |
| <a name="output_signin_url"></a> [signin\_url](#output\_signin\_url) | The URL to signin for the AWS account. |
| <a name="output_sts"></a> [sts](#output\_sts) | The account-level configurations of STS service.<br>    `global_endpoint_token_version` - The version of the STS global endpoint token. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
