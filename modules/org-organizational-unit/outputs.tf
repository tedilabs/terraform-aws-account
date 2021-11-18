output "name" {
  description = "The name of the Organizational Unit."
  value       = aws_organizations_organizational_unit.this.name
}

output "id" {
  description = "The ID of the Organizational Unit."
  value       = aws_organizations_organizational_unit.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the Organizational Unit."
  value       = aws_organizations_organizational_unit.this.arn
}

output "parent_id" {
  description = "The ID of the parent Organizational Unit."
  value       = aws_organizations_organizational_unit.this.parent_id
}

output "accounts" {
  description = "The accounts for the Organizational Unit."
  value       = aws_organizations_organizational_unit.this.accounts
}
