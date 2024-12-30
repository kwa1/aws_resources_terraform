variable "vpc_id" {
  description = "VPC ID to launch ECS resources in"
  type        = string
}

variable "public_subnet_id" {
  description = "Public Subnet ID for ECS tasks that need internet access"
  type        = string
}

variable "private_subnet_id" {
  description = "Private Subnet ID for ECS tasks without internet access"
  type        = string
}

variable "nat_gateway_id" {
  description = "NAT Gateway ID for ECS tasks in private subnets"
  type        = string
}

variable "internet_gateway_id" {
  description = "Internet Gateway ID for public subnet traffic"
  type        = string
}

variable "ec2_vpc_endpoint_id" {
  description = "EC2 VPC Endpoint ID"
  type        = string
  default     = null
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "container_image" {
  description = "Docker container image for ECS tasks"
  type        = string
}

variable "desired_task_count" {
  description = "Number of tasks to run in the ECS service"
  type        = number
}

variable "tags" {
  description = "Tags to apply to ECS resources"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Environment type (e.g., dev, prod)"
  type        = string
}
