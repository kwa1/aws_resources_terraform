provider "aws" {
  region = "us-east-1"
}

locals {
  tags = {
    Environment = "dev"
    Project     = "MyEC2Project"
  }
}
