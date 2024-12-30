variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key name for EC2 instance SSH access"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the EC2 instance"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the EC2 instance"
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "User data script to run on instance launch"
  type        = string
  default     = <<-EOT
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y aws-cli
                EOT
}
