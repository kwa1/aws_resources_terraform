variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "public_subnet_az" {
  description = "Availability Zone for the public subnet"
  type        = string
}

variable "private_subnet_az" {
  description = "Availability Zone for the private subnet"
  type        = string
}

variable "peer_vpc_id" {
  description = "ID of the VPC to peer with"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}
#You may want to expose additional configuration options for EC2 endpoints

variable "create_ec2_endpoint" {
  description = "Flag to create EC2 VPC endpoint"
  type        = bool
  default     = true
}
