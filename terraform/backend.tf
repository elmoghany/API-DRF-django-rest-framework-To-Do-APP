terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.56.1"
    }
  }

  backend "s3" {
  }
}

provider "aws" {
  region  = var.AWS_REGION
  profile = "default"
}
