output "public_ip" {
  value       = aws_instance.my-first-instance.public_ip
  description = "The public IP of the web server"
}

output "private_ip" {
  value       = aws_instance.my-first-instance.private_ip
  description = "The private IP of the web server"
}

output "instance_id" {
  value = aws_instance.my-first-instance.id
}
