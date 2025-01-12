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
