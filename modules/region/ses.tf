###################################################
# AWS SES (Simple Email Service)
###################################################

resource "aws_sesv2_account_suppression_attributes" "this" {
  region = var.region

  suppressed_reasons = var.ses.suppression_reasons
}
