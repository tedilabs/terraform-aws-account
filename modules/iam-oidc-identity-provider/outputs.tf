output "id" {
  description = "The ID of this provider."
  value       = aws_iam_openid_connect_provider.this.id
}

output "arn" {
  description = "The ARN assigned by AWS for this provider."
  value       = aws_iam_openid_connect_provider.this.arn
}

output "url" {
  description = "The URL of the identity provider."
  value       = var.url
}

output "urn" {
  description = "The URN of the identity provider."
  value       = trimprefix(trimprefix(aws_iam_openid_connect_provider.this.url, "http://"), "https://")
}

output "audiences" {
  description = "A list of audiences (also known as client IDs) for the IAM OIDC provider."
  value       = aws_iam_openid_connect_provider.this.client_id_list
}

output "thumbprints" {
  description = "A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)."
  value       = aws_iam_openid_connect_provider.this.thumbprint_list
}

output "resource_group" {
  description = "The resource group created to manage resources in this module."
  value = merge(
    {
      enabled = var.resource_group.enabled && var.module_tags_enabled
    },
    (var.resource_group.enabled && var.module_tags_enabled
      ? {
        arn  = module.resource_group[0].arn
        name = module.resource_group[0].name
      }
      : {}
    )
  )
}
