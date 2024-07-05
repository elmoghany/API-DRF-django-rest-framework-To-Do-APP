resource "aws_instance" "todo-instance" {
  ami                         = var.AMI
  instance_type               = var.INSTANCE_TYPE
  key_name                    = aws_key_pair.todo_keypair.key_name
  vpc_security_group_ids      = [aws_security_group.todo_sg_tf.id]
  associate_public_ip_address = true
  root_block_device {
    volume_type = "gp2"
    volume_size = "8"
    #delete_on_termination = true
  }
  tags = {
    Project = var.PROJECT
    Prefix  = var.PREFIX
    NAME    = "Todo-Django-DRF-Docker-TF-instance"
  }
  #  provisioner "file" {
  #    source      = "../scripts/install-docker.sh"
  #    destination = "/tmp/install-docker.sh"
  #  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo chmod 666 /var/run/docker.sock",
      "docker pull elmoghany/todo_app:v1.2-django-docker-compose",
      "docker run -d -p 8001:8000 elmoghany/todo_app:v1.2-django-docker-compose"
    ]
  }

  connection {
    type        = "ssh"
    user        = var.USER
    private_key = file(var.PRIV_KEY)
    host        = self.public_ip
    timeout     = "10m"
  }
}
