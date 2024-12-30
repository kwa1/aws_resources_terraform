#modules/ Directory
/*You can structure each module (ec2, asg, alb, route53, aws_key_pair) with its own main.tf, variables.tf,
and outputs.tf. Here’s an example for the EC2 module:

modules/ec2/main.tf
# EC2 Module

resource "aws_launch_configuration" "this" {
  name          = "asg-launch-configuration"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = var.security_group_ids
  user_data = base64encode(var.user_data)
}

resource "aws_autoscaling_group" "this" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.subnet_ids
  launch_configuration = aws_launch_configuration.this.id
  health_check_type    = "EC2"
  health_check_grace_period = 300

  target_group_arns    = [var.lb_target_group_arn]

  tag {
    key                 = "Name"
    value               = "AutoScalingInstance"
    propagate_at_launch = true
  }

  health_check_type          = "EC2"
  health_check_grace_period = 300
  force_delete              = true

  lifecycle {
    create_before_destroy = true
  }
}
modules/ec2/variables.tf
hcl
Copy code
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

variable "security_group_ids" {
  description = "List of security group IDs for EC2."
  type        = list(string)
}

variable "user_data" {
  description = "User data for EC2 instances."
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

variable "subnet_ids" {
  description = "List of subnet IDs for EC2 instances."
  type        = list(string)
}

variable "lb_target_group_arn" {
  description = "ARN of the target group for ALB."
  type        = string
}
modules/ec2/outputs.tf
hcl
Copy code
output "asg_id" {
  value = aws_autoscaling_group.this.id
}*/
#Conclusion
#With the variables, locals, outputs, and modules separated, your Terraform configuration 
#is now modular, reusable, and more maintainable. Each module can be reused independently 
#or combined in different environments with different configurations.
