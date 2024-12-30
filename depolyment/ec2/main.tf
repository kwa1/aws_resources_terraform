

# VPC and Subnet Setup
module "vpc" {
  source = "./modules/vpc"
}

# Security Group for EC2 and ALB
resource "aws_security_group" "ec2_alb_sg" {
  name        = "ec2-alb-sg"
  description = "Allow inbound HTTP, HTTPS, and SSH traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# AWS Key Pair Module
module "aws_key_pair" {
  source     = "./modules/aws_key_pair"
  key_name   = var.key_name
  public_key = var.public_key
}

# EC2 Module
module "ec2" {
  source          = "./modules/ec2"
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  key_name        = module.aws_key_pair.key_name
  security_group_ids = [aws_security_group.ec2_alb_sg.id]
  subnet_ids      = var.subnet_ids
}

# Auto Scaling Group Module
module "asg" {
  source               = "./modules/asg"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  key_name             = module.aws_key_pair.key_name
  security_group_ids   = [aws_security_group.ec2_alb_sg.id]
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  subnet_ids           = var.subnet_ids
  lb_target_group_arn  = module.alb.target_group_arn
  tags                 = var.tags
}

# ALB Module
module "alb" {
  source                  = "./modules/alb"
  name                    = "secure-alb"
  internal                = false
  subnet_ids              = var.subnet_ids
  enable_deletion_protection = false
  tags                    = var.tags
  target_group_name       = "secure-alb-target-group"
  target_group_port       = 443
  target_group_protocol   = "HTTPS"
  vpc_id                  = var.vpc_id
  target_type             = "instance"
  listener_port           = 443
  ssl_policy              = "ELBSecurityPolicy-2016-08"
  certificate_arn         = var.acm_certificate_arn
}

# Route 53 Module
module "route53" {
  source               = "./modules/route53"
  domain_name          = var.route53_domain_name
  acm_certificate_arn  = var.acm_certificate_arn
  subdomains = {
    "www" = "CNAME"
  }
  zone_tags = var.tags
  vpc_id = var.vpc_id  # Optional: Set for private hosted zones
}
