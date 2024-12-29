terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC Creation
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = local.tags
}

# Public Subnet Creation
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.public_subnet_az
  map_public_ip_on_launch = true
  tags                    = merge(local.tags, { Name = "public-subnet" })
}

# Private Subnet Creation
resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_subnet_cidr_block
  availability_zone       = var.private_subnet_az
  tags                    = merge(local.tags, { Name = "private-subnet" })
}

# Internet Gateway Creation
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.tags, { Name = "internet-gateway" })
}

# NAT Gateway Creation (for private subnet access)
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  tags          = merge(local.tags, { Name = "nat-gateway" })
}

# Route Table for Public Subnet (Internet Gateway Route)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(local.tags, { Name = "public-route-table" })
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Route Table for Private Subnet (NAT Gateway Route)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = merge(local.tags, { Name = "private-route-table" })
}

# Associate Route Table with Private Subnet
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# VPC Peering Connection (To connect with another VPC)
resource "aws_vpc_peering_connection" "this" {
  peer_vpc_id = var.peer_vpc_id
  vpc_id      = aws_vpc.this.id
  auto_accept = true

  tags = merge(local.tags, { Name = "vpc-peering" })
}

# VPC Endpoints (S3 and DynamoDB for private subnet access)
resource "aws_vpc_endpoint" "s3" {
  vpc_id             = aws_vpc.this.id
  service_name       = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids    = [aws_route_table.private.id]

  tags = merge(local.tags, { Name = "s3-vpc-endpoint" })
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id             = aws_vpc.this.id
  service_name       = "com.amazonaws.${var.aws_region}.dynamodb"
  route_table_ids    = [aws_route_table.private.id]

  tags = merge(local.tags, { Name = "dynamodb-vpc-endpoint" })
}
# optional to create the interface endpoint or not!
resource "aws_vpc_endpoint" "ec2" {
  count               = var.create_ec2_endpoint ? 1 : 0
  vpc_id             = aws_vpc.this.id
  service_name       = "com.amazonaws.${var.aws_region}.ec2"
  route_table_ids    = [aws_route_table.private.id]

  tags = merge(local.tags, { Name = "ec2-vpc-endpoint" })
}

# Security Group for EC2 Instances
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.this.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  tags = merge(local.tags, { Name = "ec2-security-group" })
}

