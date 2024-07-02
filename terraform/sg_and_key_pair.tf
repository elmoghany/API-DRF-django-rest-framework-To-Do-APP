resource "aws_key_pair" "todo_keypair" {
  key_name = var.KEY_NAME
  public_key = file(../var.PUB_KEY)
}

resource "aws_security_group" "todo_sg" {
  name		= "todo_sg"
  description	= "security group for ec2 instance of to do app"

  ingress {

  }
}
