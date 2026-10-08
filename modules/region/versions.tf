terraform {
  required_version = ">= 1.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.40"
    }
    telemetry = {
      source  = "tedilabs/telemetry"
      version = ">= 0.1.1"
    }
  }
}
