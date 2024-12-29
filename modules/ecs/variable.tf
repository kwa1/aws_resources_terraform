variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "ECS Cluster name"
  type        = string
}

variable "task_family" {
  description = "Task family name"
  type        = string
}

variable "container_definitions" {
  description = "Container definitions in JSON format"
  type        = any
}

variable "execution_role_arn" {
  description = "Execution role ARN for ECS tasks"
  type        = string
}

variable "task_role_arn" {
  description = "Task role ARN for ECS tasks"
  type        = string
}

variable "network_mode" {
  description = "Network mode for the task"
  type        = string
  default     = "awsvpc"
}

variable "requires_compatibilities" {
  description = "Launch types supported by the task"
  type        = list(string)
  default     = ["FARGATE"]
}

variable "task_cpu" {
  description = "Task CPU"
  type        = string
  default     = "256"
}

variable "task_memory" {
  description = "Task memory"
  type        = string
  default     = "512"
}

variable "launch_type" {
  description = "Launch type for ECS (FARGATE or EC2)"
  type        = string
  default     = "FARGATE"
}

# EC2-specific variables
variable "ec2_ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "ec2_instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
}

variable "ec2_subnets" {
  description = "Subnets for EC2 instances"
  type        = list(string)
}

variable "key_pair" {
  description = "Key pair name for EC2 instances"
  type        = string
}

variable "ec2_instance_profile" {
  description = "IAM Instance Profile for EC2 instances"
  type        = string
}

variable "ec2_security_groups" {
  description = "Security groups for EC2 instances"
  type        = list(string)
}

variable "ec2_user_data" {
  description = "User data script for EC2 instances"
  type        = string
  default     = ""
}

variable "asg_max_size" {
  description = "Maximum size of the ASG"
  type        = number
}

variable "asg_min_size" {
  description = "Minimum size of the ASG"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the ASG"
  type        = number
}

# Load balancer variables
variable "lb_internal" {
  description = "Is the LB internal?"
  type        = bool
  default     = false
}

variable "lb_subnets" {
  description = "Subnets for the LB"
  type        = list(string)
}

variable "lb_security_groups" {
  description = "Security groups for the LB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "container_name" {
  description = "Container name to link with the LB"
  type        = string
}

variable "container_port" {
  description = "Port for the container"
  type        = number
}

variable "listener_port" {
  description = "Port for the ALB listener"
  type        = number
  default     = 80
}

variable "target_type" {
  description = "Target type for ALB (instance, ip, lambda)"
  type        = string
  default     = "ip"
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}
