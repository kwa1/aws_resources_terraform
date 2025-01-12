# AWS Config Module

This module sets up AWS Config, including a configuration recorder, delivery channel, and a compliance rule for required tags.

## Inputs

- `config_recorder_name` - Name of the AWS Config recorder.
- `config_role_arn` - IAM role ARN for AWS Config.
- `config_delivery_channel_name` - Name of the delivery channel for AWS Config.
- `config_bucket_name` - S3 bucket name for storing AWS Config logs.

## Outputs

- `config_delivery_channel_id` - The ID of the AWS Config delivery channel.

## Example Usage

```hcl
module "config" {
  source                  = "./modules/config"
  config_recorder_name     = "my-config-recorder"
  config_role_arn          = "arn:aws:iam::123456789012:role/my-config-role"
  config_delivery_channel_name = "my-config-delivery-channel"
  config_bucket_name       = "my-config-bucket"
}
