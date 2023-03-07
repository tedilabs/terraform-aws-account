locals {
  metadata = {
    package = "terraform-aws-account"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = "attributes"
  }
}

data "aws_ssoadmin_instances" "this" {}

locals {
  sso_instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
}


resource "aws_ssoadmin_instance_access_control_attributes" "this" {
  count = length(keys(var.attributes)) > 0 ? 1 : 0

  instance_arn = local.sso_instance_arn

  dynamic "attribute" {
    for_each = var.attributes

    content {
      key = attribute.key

      value {
        source = [attribute.value]
      }
    }
  }
}
