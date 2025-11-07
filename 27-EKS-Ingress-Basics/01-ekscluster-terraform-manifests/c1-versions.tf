# Terraform Settings Block
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = ">= 4.65"
      version = ">= 5.31"
     }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "namkj-terraform-on-aws-eks"
    key    = "dev/eks-cluster/terraform.tfstate"
    # region = "us-east-1" 
    region = "ap-northeast-2" 

    # For State Locking
    dynamodb_table = "dev-ekscluster"
    # use_lockfile = true
  }  
}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}