variable "namespace" {
  description = "The namespace where metrics are stored in CloudWatch"
  type        = string
  default     = "CustomNamespace" # Default namespace
  validation {
    condition     = contains(["AWS/EC2", "AWS/EBS", "CustomNamespace"], var.namespace)
    error_message = "The namespace must be one of: AWS/EC2, AWS/EBS, or CustomNamespace."
  }
}

variable "alarm_name_prefix" {
  description = "Prefix for the CloudWatch Alarm names"
  type        = string
  default     = "AppAlarm" # Default prefix
}

variable "alarm_email" {
  description = "Email address for CloudWatch alarm notifications"
  type        = string
  default     = "" # Optional email address
  validation {
    condition     = var.alarm_email == "" || can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.alarm_email))
    error_message = "The alarm_email must be empty or a valid email address."
  }
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
    }
  ]
}

