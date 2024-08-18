output "public_ips" {
    value = aws_instance.public_servers[*].public_ip
}

output "private_ips" {
    value = aws_instance.private_servers[*].private_ip
}