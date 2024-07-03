#variable AWS_REGION {
#  default = "us-east-1"
#}
variable AMI {
  default = "ami-0c55b159cbfafe1f0"
}
variable "PROJECT" {
  default = "todo-docker-terraform"
}
variable "PREFIX" {
  default = "MOGHANY-"
}
variable "USER" {
  default = "ubuntu"
}
variable "S3_BUCKET" {
  default = "moghany-django"
}
variable "S3_KEY" {
  default = "terraform/todo-list-v1.tfstate"
}
variable "PROFILE" {
  default = "default"
}
variable "INSTANCE_TYPE" {
  default = "t2.micro"
}
variable "KEY_NAME" {
  description = "name of the ssh key pair"
  default = "moghany-todo-keypair"
}
variable "PUB_KEY" {
  default = "moghany-todo-keygen.pub"
}
variable "PRIV_KEY" {
  default = "moghany-todo-keygen"
}
