output "name" {
  description = "The name of the resource share."
  value       = aws_ram_resource_share.this.name
}

output "id" {
  description = "The ID of the resource share."
  value       = aws_ram_resource_share.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the resource share."
  value       = aws_ram_resource_share.this.arn
}

output "external_principals_allowed" {
  description = "Whether principals outside your organization can be associated with a resource share."
  value       = aws_ram_resource_share.this.allow_external_principals
}

output "permissions" {
  description = "A list of the Amazon Resource Names (ARNs) of the RAM permission associated with the resource share."
  value       = aws_ram_resource_share.this.permission_arns
}

output "principals" {
  description = "A list of the Amazon Resource Names (ARNs) of the principal associated with the resource share."
  value = toset([
    for association in aws_ram_principal_association.this :
    association.principal
  ])
}

output "resources" {
  description = "A list of the Amazon Resource Names (ARNs) of the resource associated with the resource share."
  value = toset([
    for association in aws_ram_resource_association.this :
    association.resource_arn
  ])
}
