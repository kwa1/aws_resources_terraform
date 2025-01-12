# SNS Module

resource "aws_sns_topic" "metric_alarms" {
  count = var.create_sns_topic ? 1 : 0

  name = var.sns_topic_name
}
