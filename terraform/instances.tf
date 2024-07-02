resource "aws_instance" "todo-instance" {
  ami = var.AMI
  instance_type = var.INSTANCE_TYPE
  key_name = aws_key_pair.todo_keypair.key_name
  vpc_security_group_ids = 
  subnet_id
  tags = {
	Project = var.PROJECT
	Prefix  = var.PREFIX
  }
  provisioner "file-installer" {
    source = "install-docker.sh"
    destination = "/tmp/web.sh"
  }
  provisioner "file-runner" {
    source = "run-docker.sh"
    destination = "/tmp/run-docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/install-docker.sh",
      "chmod u+x /tmp/run-docker.sh",
      "sudo /tmp/install-docker.sh",
      "sudo /tmp/run-docker.sh"
    ]
  }

  connection {
    user = var.USER
    private_key = file(../var.PRIV_KEY)
    host = self.public_ip
  }
}
