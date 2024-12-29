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

# ECS Cluster
resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
  tags = local.tags
}

# ECS Task Definition
resource "aws_ecs_task_definition" "this" {
  family                   = var.task_family
  container_definitions    = jsonencode(var.container_definitions)
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  tags                     = local.tags
}

# Launch Configuration and Auto Scaling for EC2
resource "aws_launch_template" "ecs" {
  name_prefix          = "${var.cluster_name}-"
  image_id             = var.ec2_ami_id
  instance_type        = var.ec2_instance_type
  key_name             = var.key_pair
  iam_instance_profile = var.ec2_instance_profile
  user_data            = base64encode(var.ec2_user_data)

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.ec2_security_groups
  }

  tags = local.tags
}

resource "aws_autoscaling_group" "ecs" {
  count             = var.launch_type == "EC2" ? 1 : 0
  launch_template   = { id = aws_launch_template.ecs.id }
  max_size          = var.asg_max_size
  min_size          = var.asg_min_size
  desired_capacity  = var.asg_desired_capacity
  vpc_zone_identifier = var.ec2_subnets

  tags = [
    {
      key                 = "Name"
      value               = var.cluster_name
      propagate_at_launch = true
    }
  ]
}

# ECS Service
resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_task_count
  launch_type     = var.launch_type

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  network_configuration {
    subnets         = var.service_subnets
    security_groups = var.service_security_groups
  }

  tags = local.tags
}

# Application Load Balancer
resource "aws_lb" "this" {
  name               = "${var.cluster_name}-lb"
  internal           = var.lb_internal
  load_balancer_type = "application"
  security_groups    = var.lb_security_groups
  subnets            = var.lb_subnets
  tags               = local.tags
}

# ALB Target Group
resource "aws_lb_target_group" "this" {
  name        = "${var.cluster_name}-tg"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = var.target_type

  tags = local.tags
}

# Listener
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
