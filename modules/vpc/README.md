# VPC Module

## Usage

module "vpc" {
  source = "./vpc-module"

  aws_region                  = "us-east-1"
  vpc_cidr_block              = "10.0.0.0/16"
  public_subnet_cidr_block    = "10.0.1.0/24"
  private_subnet_cidr_block   = "10.0.2.0/24"
  public_subnet_az            = "us-east-1a"
  private_subnet_az           = "us-east-1b"
  peer_vpc_id                 = "vpc-xxxxxxxx"
  tags = {
    Name        = "MyVPC"
    Environment = "dev"
  }
}

