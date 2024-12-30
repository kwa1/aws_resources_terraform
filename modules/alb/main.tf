resource "aws_lb" "this" {
  name                    = var.name
  internal                = var.internal
  load_balancer_type      = "application"
  subnets                 = var.subnet_ids
  enable_deletion_protection = var.enable_deletion_protection

  tags = merge(var.tags, { Name = var.name })
}

resource "aws_lb_target_group" "this" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  dynamic "health_check" {
    for_each = var.health_check_enabled ? [1] : []
    content {
      interval            = var.health_check_interval
      path                = var.health_check_path
      port                = var.health_check_port
      protocol            = var.health_check_protocol
      timeout             = var.health_check_timeout
      healthy_threshold   = var.healthy_threshold
      unhealthy_threshold = var.unhealthy_threshold
    }
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
