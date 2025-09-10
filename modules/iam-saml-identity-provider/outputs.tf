output "id" {
  description = "The ID of this provider."
  value       = aws_iam_saml_provider.this.id
}

output "arn" {
  description = "The ARN assigned by AWS for this provider."
  value       = aws_iam_saml_provider.this.arn
}

output "name" {
  description = "The name of the identity provider."
  value       = aws_iam_saml_provider.this.name
}

output "expire_at" {
  description = "The expiration date and time for the SAML provider in RFC1123 format, e.g., `Mon, 02 Jan 2006 15:04:05 MST`."
  value       = aws_iam_saml_provider.this.valid_until
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
