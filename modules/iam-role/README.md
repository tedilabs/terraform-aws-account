# iam-role

This module creates following resources.

- `aws_iam_role`
- `aws_iam_role_policies_exclusive` (optional)
- `aws_iam_role_policy` (optional)
- `aws_iam_role_policy_attachment` (optional)
- `aws_iam_role_policy_attachments_exclusive` (optional)
- `aws_iam_instance_profile` (optional)

## Notes

**If possible, always use PGP encryption to prevent Terraform from keeping unencrypted password and access secret key in state file.**

### Keybase

When `pgp_key` is specified as `keybase:username`, make sure that that user has already uploaded public key to keybase.io. For example, user with username `test` has done it properly and you can [verify it here](https://keybase.io/test/pgp_keys.asc).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.33.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policies_exclusive.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policies_exclusive) | resource |
| [aws_iam_role_policy.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachments_exclusive.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachments_exclusive) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.trusted_entities](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.trusted_iam_entity_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.trusted_oidc_provider_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.trusted_saml_provider_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.trusted_service_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) Desired name for the IAM role. | `string` | n/a | yes |
| <a name="input_assumable_roles"></a> [assumable\_roles](#input\_assumable\_roles) | (Optional) A set of IAM roles ARNs which can be assumed by the role. | `set(string)` | `[]` | no |
| <a name="input_conditions"></a> [conditions](#input\_conditions) | (Required) A list of required conditions to assume the role. Each item of `conditions` is defined below.<br/>    (Required) `key` - The key to match a condition for when a policy is in effect.<br/>    (Required) `condition` - The condition operator to match the condition keys and values in the policy against keys and values in the request context. Examples: `StringEquals`, `StringLike`.<br/>    (Required) `values` - A list of allowed values of the key to match a condition with condition operator. | <pre>list(object({<br/>    key       = string<br/>    condition = string<br/>    values    = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the role. | `string` | `"Managed by Terraform."` | no |
| <a name="input_exclusive_inline_policy_management_enabled"></a> [exclusive\_inline\_policy\_management\_enabled](#input\_exclusive\_inline\_policy\_management\_enabled) | (Optional) Whether to enable exclusive management for inline IAM policies of the IAM user. This includes removal of inline IAM policies which are not explicitly configured. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_exclusive_policy_management_enabled"></a> [exclusive\_policy\_management\_enabled](#input\_exclusive\_policy\_management\_enabled) | (Optional) Whether to enable exclusive management for managed IAM policies of the IAM role. This includes removal of managed IAM policies which are not explicitly configured. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | (Optional) Specifies to force detaching any policies the role has before destroying it. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_inline_policies"></a> [inline\_policies](#input\_inline\_policies) | (Optional) A map of inline IAM policies to attach to IAM role. The policy is a JSON document that you attach to an identity to specify what API actions you're allowing or denying for that identity, and under which conditions. Each key is the name of the policy, and the value is the policy document. | `map(string)` | `{}` | no |
| <a name="input_instance_profile"></a> [instance\_profile](#input\_instance\_profile) | (Optional) A configuration for instance profile. `instance_profile` is defined below.<br/>    (Optional) `enabled` - Whether to create instance profile. Defaults to `false`.<br/>    (Optional) `name` - The name of the instance profile. If omitted, Terraform will assign a ame name with the role.<br/>    (Optional) `path` - The path to the instance profile. Defaults to `/`.<br/>    (Optional) `tags` - A map of tags to add to the instance profile. | <pre>object({<br/>    enabled = optional(bool, false)<br/>    name    = optional(string)<br/>    path    = optional(string, "/")<br/>    tags    = optional(map(string), {})<br/>  })</pre> | `{}` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | (Optional) Maximum session duration (in seconds) that you want to set for the specified role. Valid value is from 1 hour (`3600`) to 12 hours (`43200`). Defaults to `3600`. | `number` | `3600` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_path"></a> [path](#input\_path) | (Optional) Desired path for the IAM role. Defaults to `/`. | `string` | `"/"` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | (Optional) The ARN of the policy that is used to set the permissions boundary for the role. | `string` | `null` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | (Optional) A set of IAM policies ARNs to attach to IAM role. | `set(string)` | `[]` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_trusted_iam_entity_policies"></a> [trusted\_iam\_entity\_policies](#input\_trusted\_iam\_entity\_policies) | (Optional) A configuration for trusted iam entity policies. Each item of `trusted_iam_entity_policies` is defined below.<br/>    (Required) `iam_entities` - A list of ARNs of AWS IAM entities who can assume the role.<br/>    (Optional) `conditions` - A list of required conditions to assume the role via IAM entities.<br/>      (Required) `key` - The key to match a condition for when a policy is in effect.<br/>      (Required) `condition` - The condition operator to match the condition keys and values in the policy against keys and values in the request context. Examples: `StringEquals`, `StringLike`.<br/>      (Required) `values` - A list of allowed values of the key to match a condition with condition operator.<br/>    (Optional) `mfa` - A configuration of MFA requirement.<br/>      (Optional) `required` - Whether to require MFA to assume role. Defaults to `false`.<br/>      (Optional) `ttl` - Max age of valid MFA (in seconds) for roles which require MFA. Defaults to `86400` (24 hours).<br/>    (Optional) `effective_date` - Allow to assume IAM role only after a specific date and time.<br/>    (Optional) `expiration_date` - Allow to assume IAM role only before a specific date and time.<br/>    (Optional) `source_ip_whitelist` - A list of source IP addresses or CIDRs allowed to assume IAM role from.<br/>    (Optional) `source_ip_blacklist` - A list of source IP addresses or CIDRs not allowed to assume IAM role from. | <pre>list(object({<br/>    iam_entities = list(string)<br/>    conditions = optional(list(object({<br/>      key       = string<br/>      condition = string<br/>      values    = list(string)<br/>    })), [])<br/>    mfa = optional(object({<br/>      required = optional(bool, false)<br/>      ttl      = optional(number, 24 * 60 * 60)<br/>    }), {})<br/>    effective_date      = optional(string)<br/>    expiration_date     = optional(string)<br/>    source_ip_whitelist = optional(list(string), [])<br/>    source_ip_blacklist = optional(list(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_trusted_oidc_provider_policies"></a> [trusted\_oidc\_provider\_policies](#input\_trusted\_oidc\_provider\_policies) | (Optional) A configuration for trusted OIDC identity provider policies. Each item of `trusted_oidc_provider_policies` is defined below.<br/>    (Required) `url` - The URL of the OIDC identity provider. If the provider is not common, the corresponding IAM OIDC Provider should be created before. Supported common OIDC providers are `accounts.google.com`, `cognito-identity.amazonaws.com`, `graph.facebook.com`, `www.amazon.com`.<br/>    (Optional) `conditions` - A list of required conditions to assume the role via OIDC providers.<br/>      (Required) `key` - The OIDC key to match a condition for when a policy is in effect.<br/>      (Required) `condition` - The condition operator to match the condition keys and values in the policy against keys and values in the request context. Examples: `StringEquals`, `StringLike`.<br/>      (Required) `values` - A list of allowed values of OIDC key to match a condition with condition operator.<br/>    (Optional) `effective_date` - Allow to assume IAM role only after a specific date and time.<br/>    (Optional) `expiration_date` - Allow to assume IAM role only before a specific date and time.<br/>    (Optional) `source_ip_whitelist` - A list of source IP addresses or CIDRs allowed to assume IAM role from.<br/>    (Optional) `source_ip_blacklist` - A list of source IP addresses or CIDRs not allowed to assume IAM role from. | <pre>list(object({<br/>    url = string<br/>    conditions = optional(list(object({<br/>      key       = string<br/>      condition = string<br/>      values    = list(string)<br/>    })), [])<br/>    effective_date      = optional(string)<br/>    expiration_date     = optional(string)<br/>    source_ip_whitelist = optional(list(string), [])<br/>    source_ip_blacklist = optional(list(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_trusted_saml_provider_policies"></a> [trusted\_saml\_provider\_policies](#input\_trusted\_saml\_provider\_policies) | (Optional) A configuration for trusted SAML identity provider policies. Each item of `trusted_saml_provider_policies` is defined below.<br/>    (Required) `name` - The name of the SAML identity provider.<br/>    (Optional) `conditions` - A list of required conditions to assume the role via SAML providers.<br/>      (Required) `key` - The SAML key to match a condition for when a policy is in effect.<br/>      (Required) `condition` - The condition operator to match the condition keys and values in the policy against keys and values in the request context. Examples: `StringEquals`, `StringLike`.<br/>      (Required) `values` - A list of allowed values of SAML key to match a condition with condition operator.<br/>    (Optional) `effective_date` - Allow to assume IAM role only after a specific date and time.<br/>    (Optional) `expiration_date` - Allow to assume IAM role only before a specific date and time.<br/>    (Optional) `source_ip_whitelist` - A list of source IP addresses or CIDRs allowed to assume IAM role from.<br/>    (Optional) `source_ip_blacklist` - A list of source IP addresses or CIDRs not allowed to assume IAM role from. | <pre>list(object({<br/>    name = string<br/>    conditions = optional(list(object({<br/>      key       = string<br/>      condition = string<br/>      values    = list(string)<br/>    })), [])<br/>    effective_date      = optional(string)<br/>    expiration_date     = optional(string)<br/>    source_ip_whitelist = optional(list(string), [])<br/>    source_ip_blacklist = optional(list(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_trusted_service_policies"></a> [trusted\_service\_policies](#input\_trusted\_service\_policies) | (Optional) A configuration for trusted service policies. Each item of `trusted_service_policies` is defined below.<br/>    (Required) `services` - A list of AWS services that can assume the role.<br/>    (Optional) `conditions` - A list of required conditions to assume the role via AWS services.<br/>      (Required) `key` - The key to match a condition for when a policy is in effect.<br/>      (Required) `condition` - The condition operator to match the condition keys and values in the policy against keys and values in the request context. Examples: `StringEquals`, `StringLike`.<br/>      (Required) `values` - A list of allowed values of the key to match a condition with condition operator.<br/>    (Optional) `effective_date` - Allow to assume IAM role only after a specific date and time.<br/>    (Optional) `expiration_date` - Allow to assume IAM role only before a specific date and time.<br/>    (Optional) `source_ip_whitelist` - A list of source IP addresses or CIDRs allowed to assume IAM role from.<br/>    (Optional) `source_ip_blacklist` - A list of source IP addresses or CIDRs not allowed to assume IAM role from. | <pre>list(object({<br/>    services = list(string)<br/>    conditions = optional(list(object({<br/>      key       = string<br/>      condition = string<br/>      values    = list(string)<br/>    })), [])<br/>    effective_date      = optional(string)<br/>    expiration_date     = optional(string)<br/>    source_ip_whitelist = optional(list(string), [])<br/>    source_ip_blacklist = optional(list(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_trusted_session_tagging"></a> [trusted\_session\_tagging](#input\_trusted\_session\_tagging) | (Optional) A configurations of session tags in AWS STS. `trusted_session_tagging` block as defined below.<br/>    (Optional) `enabled` - Indicate whether you want to enable session tagging. Defaults to `true`.<br/>    (Optional) `allowed_tags` - A map of tag key/values pairs to limit the tag keys and values that can be used as session tags.<br/>    (Optional) `allowed_transitive_tag_keys` - A set of tag keys to limit the maximum set of transitive tags. | <pre>object({<br/>    enabled                     = optional(bool, true)<br/>    allowed_tags                = optional(map(set(string)), {})<br/>    allowed_transitive_tag_keys = optional(set(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_trusted_source_identity"></a> [trusted\_source\_identity](#input\_trusted\_source\_identity) | (Optional) A configurations of source identity in AWS STS. `trusted_source_identity` block as defined below.<br/>    (Optional) `enabled` - Indicate whether you want to enable source identity configuration. Defaults to `true`.<br/>    (Optional) `allowed_identities` - A set of identities to limit the maximum set of source identities. | <pre>object({<br/>    enabled            = optional(bool, true)<br/>    allowed_identities = optional(set(string), [])<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the IAM role. |
| <a name="output_assumable_roles"></a> [assumable\_roles](#output\_assumable\_roles) | A set of ARNs of IAM roles which members of IAM role can assume. |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Creation date of the IAM role. |
| <a name="output_description"></a> [description](#output\_description) | The description of the role. |
| <a name="output_exclusive_inline_policy_management_enabled"></a> [exclusive\_inline\_policy\_management\_enabled](#output\_exclusive\_inline\_policy\_management\_enabled) | Whether exclusive inline policy management is enabled for the IAM role. |
| <a name="output_exclusive_policy_management_enabled"></a> [exclusive\_policy\_management\_enabled](#output\_exclusive\_policy\_management\_enabled) | Whether exclusive policy management is enabled for the IAM role. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IAM role. |
| <a name="output_inline_policies"></a> [inline\_policies](#output\_inline\_policies) | A set of names of inline IAM polices which are attached to IAM role. |
| <a name="output_instance_profile"></a> [instance\_profile](#output\_instance\_profile) | The instance profile associated with the IAM Role.<br/>    `id` - The instance profile's ID.<br/>    `arn` - The ARN assigned by AWS for the instance profile.<br/>    `name` - The name of the instance profile.<br/>    `path` - The path to the instance profile.<br/>    `created_at` - Creation timestamp of the instance profile. |
| <a name="output_name"></a> [name](#output\_name) | IAM Role name. |
| <a name="output_path"></a> [path](#output\_path) | The path of the IAM role. |
| <a name="output_policies"></a> [policies](#output\_policies) | A set of ARNs of IAM policies which are atached to IAM role. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | The unique ID assigned by AWS. |
<!-- END_TF_DOCS -->
