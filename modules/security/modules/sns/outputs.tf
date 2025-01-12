output "sns_topic_arn" {
  description = "The ARN of the SNS topic."
  value       = aws_sns_topic.metric_alarms[0].arn
  condition   = var.create_sns_topic
}
