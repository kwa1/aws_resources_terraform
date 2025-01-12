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

variable "region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-west-2"
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
  default = [
    {
      name               = "HighCPUUtilization"
      metric_name        = "cpu_usage_active"
      threshold          = 80
      evaluation_periods = 2
      period             = 300
      statistic          = "Average"
      comparison_operator = "GreaterThanThreshold"
    },
    {
      name               = "LowMemoryAvailable"
      metric_name        = "mem_available_percent"
      threshold          = 20
      evaluation_periods = 2
      period             = 300
      statistic          = "Average"
      comparison_operator = "LessThanThreshold"
    },
    {
      name               = "HighDiskUsage"
      metric_name        = "disk_used_percent"
      threshold          = 90
      evaluation_periods = 2
      period             = 300
      statistic          = "Average"
      comparison_operator = "GreaterThanThreshold"
    },
    {
      name               = "HighNetworkErrorRate"
      metric_name        = "errors_out"
      threshold          = 10
      evaluation_periods = 2
      period             = 300
      statistic          = "Sum"
      comparison_operator = "GreaterThanThreshold"
    },
    {
      name               = "HighReadIO"
      metric_name        = "read_bytes"
      threshold          = 500000000  # 500 MB
      evaluation_periods = 2
      period             = 300
      statistic          = "Sum"
      comparison_operator = "GreaterThanThreshold"
    },
    {
      name               = "HighWriteIO"
      metric_name        = "write_bytes"
      threshold          = 500000000  # 500 MB
      evaluation_periods = 2
      period             = 300
      statistic          = "Sum"
      comparison_operator = "GreaterThanThreshold"
    }
  ]
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
  alarm_actions    = var.alarm_email != "" ? [aws_sns_topic.metric_alarms.arn] : []
  ok_actions       = var.alarm_email != "" ? [aws_sns_topic.metric_alarms.arn] : []
}

resource "aws_sns_topic" "metric_alarms" {
  name = "${var.alarm_name_prefix}-metric-alarms"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  count     = var.alarm_email != "" ? 1 : 0
  topic_arn = aws_sns_topic.metric_alarms.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

resource "aws_cloudwatch_dashboard" "system_dashboard" {
  dashboard_name = "${var.alarm_name_prefix}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        "type"       : "metric",
        "x"          : 0,
        "y"          : 0,
        "width"      : 6,
        "height"     : 6,
        "properties" : {
          "metrics": [
            [var.namespace, "cpu_usage_active", "InstanceId", "${aws:InstanceId}"],
            [".", "mem_used_percent", ".", "."]
          ],
          "period"     : 300,
          "stat"       : "Average",
          "title"      : "System Metrics",
          "view"       : "timeSeries",
          "region"     : var.namespace
        }
      },
      {
        "type"       : "alarm",
        "x"          : 6,
        "y"          : 0,
        "width"      : 6,
        "height"     : 6,
        "properties" : {
          "alarms": [
            aws_cloudwatch_metric_alarm.metric_alarms["HighCPUUtilization"].alarm_arn,
            aws_cloudwatch_metric_alarm.metric_alarms["LowMemoryAvailable"].alarm_arn
          ],
          "title" : "Alarms Overview"
        }
      }
    ]
  })
}

