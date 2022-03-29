output "subnet_public_id" {
  value = aws_subnet.public.id
}

output "subnet_private_id" {
  value = aws_subnet.private.id
}

output "sg_allow_ssh_id" {
  value = aws_security_group.allow_ssh.id
}

output "sg_allow_ssh2_id" {
  value = aws_security_group.allow_ssh2.id
}
