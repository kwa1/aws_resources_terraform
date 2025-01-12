variable "security_alarm_config" {
  description = "Configuration for CloudWatch security alarms."
  type = list(object({
    name                = string
    metric_name         = string
    namespace           = string
    threshold           = number
    evaluation_periods  = number
    period              = number
    statistic           = string
    comparison_operator = string
  }))
}

variable "alarm_name_prefix" {
  description = "Prefix for alarm names."
  type        = string
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS topic for alarm notifications."
  type        = string
  default     = ""
}
