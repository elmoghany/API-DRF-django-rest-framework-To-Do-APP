output "Public-IP" {
  value = aws_instance.todo-instance.public_ip
}
output "Private-IP" {
  value = aws_instance.todo-instance.private_ip
}
