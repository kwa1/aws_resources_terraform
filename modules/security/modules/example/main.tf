module "config" {
  source                  = "./modules/config"
  config_recorder_name     = "my-config-recorder"
  config_role_arn          = "arn:aws:iam::123456789012:role/my-config-role"
  config_delivery_channel_name = "my-config-delivery-channel"
  config_bucket_name       = "my-config-bucket"
  enable_config_rule       = true
}

module "guardduty" {
  source              = "./modules/guardduty"
  guardduty_accounts  = {
    "123456789012" = "account1@example.com",
    "987654321098" = "account2@example.com"
  }
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
  security_alarm_config = [
    {
      name                = "UnauthorizedAPICalls"
      metric_name         = "UnauthorizedAPICalls"
      namespace           = "AWS/CloudTrail"
      threshold           = 1
      evaluation_periods  = 1
      period              = 300
      statistic           = "Sum"
      comparison_operator = "GreaterThanOrEqualToThreshold"
    }
  ]
  alarm_name_prefix     = "security-alarm"
  sns_topic_arn         = module.sns.sns_topic_arn
}

module "sns" {
  source          = "./modules/sns"
  sns_topic_name  = "my-metric-alarms-topic"
  create_sns_topic = true
}
