resource "aws_key_pair" "todo_keypair" {
  key_name   = var.KEY_NAME
  public_key = file(var.PUB_KEY)
}

data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_security_group" "todo_sg_tf" {
  name        = "todo-sg-tf"
  description = "Allow HTTPS to web server"
  vpc_id      = data.aws_vpc.default_vpc.id
}

#egress
resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.todo_sg_tf.id
}

#ingress
resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  description       = "HTTPS ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.todo_sg_tf.id
}
resource "aws_security_group_rule" "allow_custom_port" {
  type              = "ingress"
  description       = "Custom port for Django"
  from_port         = 8001
  to_port           = 8001
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.todo_sg_tf.id
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  description       = "HTTP ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.todo_sg_tf.id
}
resource "aws_security_group_rule" "allow_ssh_from_vpc" {
  type        = "ingress"
  description = "Allow SSH from VPC"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  #cidr_blocks = [data.aws_vpc.default_vpc.cidr_block]
  cidr_blocks       = [var.MYIP]
  security_group_id = aws_security_group.todo_sg_tf.id
}


#resource "aws_security_group" "todo_sg" {
#  name		= "todo_sg_tf"
#  description	= "security group for ec2 instance of to do app"
#  vpc_id 	= data.aws_vpc.default_vpc.id
#
#  ingress {
#    description = "HTTPS ingress"
#    from_port   = 443
#    to_port     = 443
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}
