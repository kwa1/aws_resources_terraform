

variable "ami_id" {
  description = "The AMI ID for EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair."
  type        = string
}

variable "public_key" {
  description = "The public key for SSH access."
  type        = string
}

variable "desired_capacity" {
  description = "Desired capacity for the Auto Scaling Group."
  type        = number
}

variable "max_size" {
  description = "Maximum size for the Auto Scaling Group."
  type        = number
}

variable "min_size" {
  description = "Minimum size for the Auto Scaling Group."
  type        = number
}

variable "vpc_id" {
  description = "VPC ID where the resources will be deployed."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EC2 instances and load balancer."
  type        = list(string)
}

variable "lb_type" {
  description = "The type of load balancer (application or network)."
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for the ALB."
  type        = string
}

variable "route53_domain_name" {
  description = "The domain name for Route 53."
  type        = string
}
