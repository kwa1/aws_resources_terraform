# CloudWatch Alarms Module

This module creates CloudWatch metric alarms based on the provided configuration.

## Inputs

- `security_alarm_config` - List of objects with alarm configuration.

## Outputs

- `security_alarm_arns` - The ARNs of the created CloudWatch alarms.

## Example Usage

```hcl
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
}
