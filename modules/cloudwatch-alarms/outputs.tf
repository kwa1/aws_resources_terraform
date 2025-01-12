output "alarm_topic_arn" {
  value       = aws_sns_topic.metric_alarms.arn
  description = "ARN of the SNS topic used for CloudWatch alarm notifications"
}

output "dashboard_name" {
  value       = aws_cloudwatch_dashboard.system_dashboard.dashboard_name
  description = "Name of the CloudWatch dashboard for system metrics"
}

output "alarm_names" {
  value       = [for alarm in var.metrics_alarm_config : "${var.alarm_name_prefix}-${alarm.name}"]
  description = "List of all CloudWatch alarm names"
}

output "dashboard_arn" {
  value       = aws_cloudwatch_dashboard.system_dashboard.arn
  description = "ARN of the CloudWatch dashboard for system metrics"
}
