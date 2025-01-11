variable "namespace" {
  description = "The namespace where metrics are stored in CloudWatch"
  type        = string
}

variable "alarm_name_prefix" {
  description = "Prefix for the CloudWatch Alarm names"
  type        = string
}

variable "alarm_email" {
  description = "Email address for CloudWatch alarm notifications"
  type        = string
}

variable "metrics_alarm_config" {
  description = "Configuration for CloudWatch alarms"
  type = list(
    object({
      name                = string
      metric_name         = string
      threshold           = number
      evaluation_periods  = number
      period              = number
      statistic           = string
      comparison_operator = string
    })
  )
}

resource "aws_cloudwatch_metric_alarm" "metric_alarms" {
  for_each = { for alarm in var.metrics_alarm_config : alarm.name => alarm }

  alarm_name          = "${var.alarm_name_prefix}-${each.value.name}"
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  metric_name         = each.value.metric_name
  namespace           = var.namespace
  period              = each.value.period
  statistic           = each.value.statistic
  threshold           = each.value.threshold

  actions_enabled = true
  alarm_actions    = [aws_sns_topic.metric_alarms.arn]
  ok_actions       = [aws_sns_topic.metric_alarms.arn]
}

resource "aws_sns_topic" "metric_alarms" {
  name = "${var.alarm_name_prefix}-metric-alarms"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.metric_alarms.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}
