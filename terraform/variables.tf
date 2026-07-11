variable "region" {
  description = "AWS Region"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "instance_name" {
  description = "EC2 Instance Name"
  type        = string
}

variable "key_name" {
  description = "AWS Key Pair Name"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnet_name" {
  description = "Public Subnet Name"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR Block"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
}

variable "internet_gateway_name" {
  description = "Internet Gateway Name"
  type        = string
}

variable "route_table_name" {
  description = "Route Table Name"
  type        = string
}

variable "security_group_name" {
  description = "Security Group Name"
  type        = string
}

variable "ssh_cidr_block" {
  description = "CIDR block allowed to SSH"
  type        = string
}
