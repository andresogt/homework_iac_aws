output "sg_id" {
  value = aws_security_group.allow_http_ssh.id
}

output "subnet_id_ec2" {
  value = aws_subnet.public_subnet1.id
}

