terraform {
  backend "s3" {
    bucket = var.S3_BUCKET
    key    = "terraform/todo-list-v1"
    region = var.REGION
  }
}
