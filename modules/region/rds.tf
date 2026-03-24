###################################################
# Default Certificate Block for RDS
###################################################

# INFO: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html#UsingWithRDS.SSL.CertificateIdentifier
resource "aws_rds_certificate" "this" {
  count = var.rds.default_certificate_identifier != null ? 1 : 0

  region = var.region

  certificate_identifier = var.rds.default_certificate_identifier
}
