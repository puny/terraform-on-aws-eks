# Terraform Settings Block
terraform {
  required_version = "~> 1.12"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = ">= 4.65"
      #version = ">= 5.31"
      version = "~> 6.0"
     }
  }
}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}