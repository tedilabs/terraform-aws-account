# iam-oidc-identity-provider

This module creates following resources.

- `aws_iam_openid_connect_provider`


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.36 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.50.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [tls_certificate.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_url"></a> [url](#input\_url) | (Required) The secure OpenID Connect URL for authentication requests. Correspond to the `iss` claim. Maximum 255 characters. URL must begin with `https://`. | `string` | n/a | yes |
| <a name="input_audiences"></a> [audiences](#input\_audiences) | (Optional) A list of audiences (also known as client IDs) for the IAM OIDC provider. When a mobile or web app registers with an OpenID Connect provider, they establish a value that identifies the application. This is the value that's sent as the `client_id` parameter on OAuth requests. Defaults to STS service(`sts.amazonaws.com`) if not values are provided. | `set(string)` | <pre>[<br>  "sts.amazonaws.com"<br>]</pre> | no |
| <a name="input_auto_thumbprint_enabled"></a> [auto\_thumbprint\_enabled](#input\_auto\_thumbprint\_enabled) | (Optional) Whether to automatically calculate thumbprint of the server certificate. | `bool` | `true` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_thumbprints"></a> [thumbprints](#input\_thumbprints) | (Optional) A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s). | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN assigned by AWS for this provider. |
| <a name="output_audiences"></a> [audiences](#output\_audiences) | A list of audiences (also known as client IDs) for the IAM OIDC provider. |
| <a name="output_id"></a> [id](#output\_id) | The ID of this provider. |
| <a name="output_thumbprints"></a> [thumbprints](#output\_thumbprints) | A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s). |
| <a name="output_url"></a> [url](#output\_url) | The URL of the identity provider. |
| <a name="output_urn"></a> [urn](#output\_urn) | The URN of the identity provider. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
