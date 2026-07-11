output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.todo_server.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.todo_server.public_ip
}

output "public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.todo_server.public_dns
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.todo_vpc.id
}

output "public_subnet_id" {
  description = "Public Subnet ID"
  value       = aws_subnet.public_subnet.id
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.todo_sg.id
}
