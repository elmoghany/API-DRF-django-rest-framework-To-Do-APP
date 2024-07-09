resource "aws_instance" "todo-instance" {
  ami                         = var.AMI
  instance_type               = var.INSTANCE_TYPE
  key_name                    = aws_key_pair.todo_keypair.key_name
  vpc_security_group_ids      = [aws_security_group.todo_sg_tf.id]
  associate_public_ip_address = true
  root_block_device {
    volume_type = "gp3"
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
	"mkdir -p /home/ubuntu/todo-project/todo_project",
	"mkdir -p /home/ubuntu/todo-project/scripts",
	"mkdir -p /home/ubuntu/todo-project/nginx",
	"mkdir -p /home/ubuntu/todo-project/todo_project",
  	]
  }
  provisioner "file" {
    source      = "../scripts/"
    destination = "/home/ubuntu/todo-project/scripts/"
  }
  provisioner "file" {
    source      = "../todo_project/.env"
    destination = "/home/ubuntu/todo-project/todo_project/.env"
  }
  provisioner "file" {
    source      = "../nginx/"
    destination = "/home/ubuntu/todo-project/nginx/"
  }
  provisioner "file" {
    source      = "../requirements.txt"
    destination = "/home/ubuntu/todo-project/requirements.txt"
  }
  provisioner "file" {
    source      = "../docker-compose.yml"
    destination = "/home/ubuntu/todo-project/docker-compose.yml"
  }
#  provisioner "file" {
#    source      = "../todo_project/Dockerfile"
#    destination = "/home/ubuntu/todo-project/todo_project/Dockerfile"
#  }
#  provisioner "file" {
#    source      = "../todo_project/"
#    destination = "/home/ubuntu/todo-project/todo_project/"
#  }
  provisioner "remote-exec" {
    inline = [
	"chmod +x /home/ubuntu/todo-project/scripts/entrypoint.sh",
	"chmod +x /home/ubuntu/todo-project/scripts/run-docker.sh",
	"bash /home/ubuntu/todo-project/scripts/entrypoint.sh",
    ]
  }

  provisioner "remote-exec" {
    inline = [
    	"ls -ltr /home/ubuntu/todo-project/todo_project/",
	"bash /home/ubuntu/todo-project/scripts/run-docker.sh",
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
