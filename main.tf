resource "aws_autoscaling_group" "this" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.subnet_ids
  launch_configuration = var.launch_configuration_id
  target_group_arns    = [var.lb_target_group_arn]

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }

  health_check_type          = "EC2"
  health_check_grace_period = 300
  force_delete              = true

  lifecycle {
    create_before_destroy = true
  }
}

output "asg_id" {
  value = aws_autoscaling_group.this.id
}
