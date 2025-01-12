# SNS Module

This module creates an SNS topic for CloudWatch alarm notifications.

## Inputs

- `sns_topic_name` - The name of the SNS topic.

## Outputs

- `sns_topic_arn` - The ARN of the SNS topic.

## Example Usage

```hcl
module "sns" {
  source = "./modules/sns"
  sns_topic_name = "my-metric-alarms-topic"
}
