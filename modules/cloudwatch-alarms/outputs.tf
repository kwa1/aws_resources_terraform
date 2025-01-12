output "alarm_topic_arn" {
  value = aws_sns_topic.metric_alarms.arn
}
output "dashboard_name" {
  value = aws_cloudwatch_dashboard.system_dashboard.dashboard_name
  description = "Name of the CloudWatch dashboard for system metrics"
}
