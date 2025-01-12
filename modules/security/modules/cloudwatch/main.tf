# CloudWatch Alarms Module

resource "aws_cloudwatch_metric_alarm" "security_alarms" {
  for_each = { for alarm in var.security_alarm_config : alarm.name => alarm if alarm.threshold > 0 }

  alarm_name          = "${var.alarm_name_prefix}-${each.value.name}"
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  metric_name         = each.value.metric_name
  namespace           = each.value.namespace
  period              = each.value.period
  statistic           = each.value.statistic
  threshold           = each.value.threshold

  actions_enabled = true
  alarm_actions    = var.sns_topic_arn != "" ? [var.sns_topic_arn] : []
  ok_actions       = var.sns_topic_arn != "" ? [var.sns_topic_arn] : []
}
