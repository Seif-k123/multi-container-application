# =========================
# VPC
# =========================
resource "aws_vpc" "todo_vpc" {

  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# =========================
# Internet Gateway
# =========================
resource "aws_internet_gateway" "todo_igw" {

  vpc_id = aws_vpc.todo_vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
}

# =========================
# Public Subnet
# =========================
resource "aws_subnet" "public_subnet" {

  vpc_id                  = aws_vpc.todo_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_name
  }
}

# =========================
# Route Table
# =========================
resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.todo_vpc.id

  tags = {
    Name = var.route_table_name
  }
}

# =========================
# Default Route
# =========================
resource "aws_route" "internet_access" {

  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.todo_igw.id
}

# =========================
# Route Table Association
# =========================
resource "aws_route_table_association" "public_assoc" {

  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# =========================
# Security Group
# =========================
resource "aws_security_group" "todo_sg" {

  name   = var.security_group_name
  vpc_id = aws_vpc.todo_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr_block]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}

# =========================
# EC2 Instance
# =========================
resource "aws_instance" "todo_server" {

  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.todo_sg.id]

  tags = {
    Name = var.instance_name
  }
}
resource "local_file" "ansible_inventory" {
  filename = "../ansible/inventory.ini"

  content = <<EOF
[servers]
${aws_instance.todo_server.public_ip}

[servers:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/${var.key_name}.pem
ansible_python_interpreter=/usr/bin/python3
EOF
}
