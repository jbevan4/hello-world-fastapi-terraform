
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "example-org-5ecb05"

    workspaces {
      name = "terraform-gha-demo"
    }
  }
}

# Provider
provider "aws" {
  region = var.region
}