config {
  plugin_dir = "~/.tflint.d/plugins"

  format = "compact"
  call_module_type = "local"
  force = false
  disabled_by_default = false

  ignore_module = {}
}


###################################################
# Rule Sets - Terraform
###################################################

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

rule "terraform_comment_syntax" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
  format = "snake_case"

  custom_formats = {
    extended_snake_case = {
      description = "Extended snake_case Format which allows double underscore like `a__b`."
      regex       = "^[a-z][a-z0-9]+([_]{1,2}[a-z0-9]+)*$"
    }
  }

  module {
    format = "extended_snake_case"
  }

  resource {
    format = "extended_snake_case"
  }

  data {
    format = "extended_snake_case"
  }

  locals {
    format = "extended_snake_case"
  }

  variable {
    format = "extended_snake_case"
  }

  output {
    format = "extended_snake_case"
  }

  check {
    format = "extended_snake_case"
  }
}

rule "terraform_unused_declarations" {
  enabled = false
}

rule "terraform_unused_required_providers" {
  enabled = true
}


###################################################
# Rule Sets - AWS
###################################################

plugin "aws" {
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  version = "0.44.0"

  enabled = true
  deep_check = false
}

rule "aws_iam_policy_attachment_exclusive_attachment" {
  enabled = true
}

rule "aws_iam_role_deprecated_policy_attributes" {
  enabled = true
}

rule "aws_security_group_inline_rules" {
  enabled = true
}

rule "aws_security_group_rule_deprecated" {
  enabled = true
}
