variable "config_recorder_name" {
  description = "Name for the AWS Config recorder."
  type        = string
}

variable "config_role_arn" {
  description = "IAM role ARN for AWS Config."
  type        = string
}

variable "config_delivery_channel_name" {
  description = "Name for the AWS Config delivery channel."
  type        = string
}

variable "config_bucket_name" {
  description = "S3 bucket name for AWS Config logs."
  type        = string
}

variable "enable_config_rule" {
  description = "Whether to enable the Config rule for required tags."
  type        = bool
  default     = true
}
