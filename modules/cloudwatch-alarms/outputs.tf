output "alarm_topic_arn" {
  value = aws_sns_topic.metric_alarms.arn
}
