terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.56.1"
    }
  }

  backend "s3" {
    config {
      bucket 	= "${var.S3_BUCKET}"
      key	= "${var.S3_KEY}" 
      region 	= "${var.REGION}"
      shared_credentials_file = "./.env.tfvars"
    }
  }
}

provider "aws" {
  region  = var.REGION
}
