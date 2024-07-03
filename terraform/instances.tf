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
  }
  provisioner "file" {
    source      = "install-docker.sh"
    destination = "/tmp/web.sh"
  }
  provisioner "file" {
    source      = "run-docker.sh"
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
    user        = var.USER
    private_key = file(var.PRIV_KEY)
    host        = self.public_ip
  }
}
