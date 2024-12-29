#Using Fargate:
#If you're deploying a stateless #web application, you can set launch_type = "FARGATE", and the ECS tasks will automatically run in Fargate. You don’t need to worry about EC2 instance management. 
#The load balancer will route traffic to the Fargate tasks.
module "ecs" {
  source             = "./ecs-module"
  aws_region         = "us-west-2"
  cluster_name       = "my-cluster"
  task_family        = "my-task-family"
  container_definitions = [...]  # JSON container definition
  execution_role_arn = "arn:aws:iam::account-id:role/my-execution-role"
  task_role_arn      = "arn:aws:iam::account-id:role/my-task-role"
  launch_type        = "FARGATE"
  container_name     = "my-container"
  container_port     = 8080
  lb_subnets         = ["subnet-abc123", "subnet-def456"]
  lb_security_groups = ["sg-abc123"]
  vpc_id             = "vpc-abc123"
  tags               = { Project = "Fargate App" }
}

#Using EC2:
#If you want to run the service on EC2 instances with scaling, set launch_type = "EC2", and the module will create EC2 instances in an ASG to run your ECS tasks. 
#The load balancer will route traffic to the EC2 instances.
module "ecs" {
  source             = "./ecs-module"
  aws_region         = "us-west-2"
  cluster_name       = "my-ec2-cluster"
  task_family        = "my-task-family"
  container_definitions = [...]  # JSON container definition
  execution_role_arn = "arn:aws:iam::account-id:role/my-execution-role"
  task_role_arn      = "arn:aws:iam::account-id:role/my-task-role"
  launch_type        = "EC2"
  container_name     = "my-container"
  container_port     = 8080
  ec2_ami_id         = "ami-abc123"
  ec2_instance_type  = "t2.micro"
  ec2_subnets        = ["subnet-abc123", "subnet-def456"]
  ec2_security_groups = ["sg-abc123"]
  lb_subnets         = ["subnet-abc123", "subnet-def456"]
  lb_security_groups = ["sg-abc123"]
  vpc_id             = "vpc-abc123"
  tags               = { Project = "EC2 App" }
}
