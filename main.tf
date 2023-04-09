provider "aws" {
   region = var.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.30"
    }
    
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }

  backend "s3" {
    bucket = "rbgsandbox"
    key    = "apigwlambdadynamo.tfstatefile"
    region = "us-east-1"
  }
}