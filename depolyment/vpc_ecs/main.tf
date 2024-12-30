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

module "ecs" {
  source = "./ecs-module"

  # Pass VPC outputs as inputs to ECS module
  vpc_id                 = module.vpc.vpc_id
  public_subnet_id       = module.vpc.public_subnet_id
  private_subnet_id      = module.vpc.private_subnet_id
  nat_gateway_id         = module.vpc.nat_gateway_id
  internet_gateway_id    = module.vpc.internet_gateway_id
  ec2_vpc_endpoint_id    = module.vpc.ec2_vpc_endpoint_id

  ecs_cluster_name       = "MyECSCluster"
  ecs_service_name       = "MyECSService"
  container_image        = "nginx:latest"
  desired_task_count     = 2
  environment            = "production"
  tags                   = { Name = "MyECS" }
}

resource "aws_ecs_cluster" "this" {
  name = var.ecs_cluster_name
  tags = merge(var.tags, { Environment = var.environment })
}

resource "aws_ecs_task_definition" "this" {
  family                = var.ecs_service_name
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                    = "256"
  memory                 = "512"
  container_definitions = jsonencode([{
    name      = var.ecs_service_name
    image     = var.container_image
    essential = true
    portMappings = [
      {
        containerPort = 80
        hostPort      = 80
        protocol      = "tcp"
      }
    ]
  }])

  tags = merge(var.tags, { Environment = var.environment })
}

resource "aws_ecs_service" "this" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_task_count
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [var.public_subnet_id, var.private_subnet_id]
    security_groups = [aws_security_group.ec2_sg.id]
    assign_public_ip = true
  }
  tags = merge(var.tags, { Environment = var.environment })
}
