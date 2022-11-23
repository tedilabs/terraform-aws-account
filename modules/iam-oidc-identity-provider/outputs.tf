output "arn" {
  description = "The ARN assigned by AWS for this provider."
  value       = aws_iam_openid_connect_provider.this.arn
}

output "url" {
  description = "The URL of the identity provider."
  value       = aws_iam_openid_connect_provider.this.url
}

output "audiences" {
  description = "A list of audiences (also known as client IDs) for the IAM OIDC provider."
  value       = aws_iam_openid_connect_provider.this.client_id_list
}

output "thumbprints" {
  description = "A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)."
  value       = aws_iam_openid_connect_provider.this.thumbprint_list
}
