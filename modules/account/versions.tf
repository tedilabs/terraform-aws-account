terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.10"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = ">= 0.75"
    }
  }
}
