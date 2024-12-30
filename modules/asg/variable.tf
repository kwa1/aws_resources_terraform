variable "vpc_id" {
  description = "VPC ID to launch the ASG"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch the ASG instances in"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instances in the ASG"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "desired_capacity" {
  description = "Desired capacity of the ASG"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum size of the ASG"
  type        = number
  default     = 5
}

variable "min_size" {
  description = "Minimum size of the ASG"
  type        = number
  default     = 1
}

variable "key_name" {
  description = "Key name for EC2 instances"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the EC2 instances"
  type        = list(string)
}

variable "lb_target_group_arn" {
  description = "Target group ARN for the load balancer"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the ASG instances"
  type        = map(string)
  default     = {}
}
