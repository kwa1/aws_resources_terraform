module "cloudwatch_alarms" {
  source = "./modules/cloudwatch-alarms"

  namespace            = "LocalMachine/CWAgent"
  alarm_name_prefix    = "LocalMachine"
  alarm_email          = "alert@example.com"
  metrics_alarm_config = [
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
    }
  ]
}
