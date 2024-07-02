terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.56.1"
    }
  }

  backend "s3" {
    bucket = "var.S3_BUCKET"
    key    = "terraform/todo-list-v1"
  }
}

provider "aws" {
  region  = var.REGION
}
