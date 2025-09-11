terraform {
  required_version = ">= 1.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.12"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.1"
    }
  }
}
