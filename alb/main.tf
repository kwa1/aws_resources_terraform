resource "aws_lb" "this" {
  name                    = var.name
  internal                = var.internal
  load_balancer_type      = var.lb_type
  security_groups         = var.security_group_ids
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

  health_check {
    interval            = var.health_check_interval
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    timeout             = var.health_check_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_http_port
  protocol          = var.listener_http_protocol

  default_action {
    type = var.default_action_type

    fixed_response {
      status_code = var.fixed_response_status_code
      content_type = var.fixed_response_content_type
      message_body = var.fixed_response_message_body
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_https_port
  protocol          = var.listener_https_protocol
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
