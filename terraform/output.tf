output "web_public_ip" {
  value = aws_instance.web.public_ip
}


output "ansible_public_ip" {
  value = aws_instance.ansible.public_ip
}
