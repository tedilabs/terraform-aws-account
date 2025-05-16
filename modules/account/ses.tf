###################################################
# AWS SES (Simple Email Service)
###################################################

resource "aws_sesv2_account_suppression_attributes" "this" {
  suppressed_reasons = var.ses.suppression_reasons
}
