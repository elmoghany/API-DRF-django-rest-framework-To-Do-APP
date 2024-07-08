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
    Name    = "Todo-Django-DRF-Docker-TF-instance"
  }
  provisioner "remote-exec" {
    inline = [
	"mkdir -p /home/ubuntu/todo-project/scripts"
  	]
  }
  provisioner "file" {
    source      = "../scripts/entrypoint.sh"
    destination = "/home/ubuntu/todo-project/scripts/entrypoint.sh"
  }
  provisioner "file" {
    source      = "../.env"
    destination = "/home/ubuntu/todo-project/.env"
  }
  provisioner "file" {
    source      = "../docker-compose.yml"
    destination = "/home/ubuntu/todo-project/scripts/docker-compose.yml"
  }
  provisioner "remote-exec" {
    inline = [
	"chmod +x /home/ubuntu/todo-project/scripts/entrypoint.sh",
	"bash /home/ubuntu/todo-project/scripts/entrypoint.sh"
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

#  provisioner "remote-exec" {
#    inline = [
#      "sudo apt-get update",
#      "sudo apt-get install -y docker.io",
#      "sudo systemctl start docker",
#      "sudo systemctl enable docker",
#      "sudo usermod -aG docker ubuntu",
#      "sudo curl -L "https://github.com/docker/compose/releases/download/v2.28.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose",
#      "sudo chmod +x /usr/local/bin/docker-compose",
#      "sudo chmod 666 /var/run/docker.sock",
#      "mkdir -p /home/ubuntu/todo-project",
#      "cd /home/ubuntu/todo-project",
#      "docker pull elmoghany/todo_app:v1.3-django-docker-compose",
#     "docker run -d -p 8001:8000 elmoghany/todo_app:v1.3-django-docker-compose"
#      "docker compose up -d"
#    ]
#  }

