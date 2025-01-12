variable "sns_topic_name" {
  description = "The name of the SNS topic."
  type        = string
  default     = "metric-alarms-topic"
}

variable "create_sns_topic" {
  description = "Flag to create the SNS topic."
  type        = bool
  default     = true
}
