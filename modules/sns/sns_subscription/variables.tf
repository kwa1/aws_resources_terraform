variable "protocol" {
  description = "Protocol to use. Valid values are: sqs, sms, lambda, firehose, and application. Protocols email, email-json, http and https are also valid but partially supported."
  validation {
    error_message = "Protocol should be sqs, sms, lambda, firehose, application, email, email-json, http or https."
    condition     = can(regex("sqs|sms|lambda|firehose|application|email|email-json|http|https", var.protocol))
  }
}
variable "topic_arn" {}
variable "endpoint" {}

variable "redrive_policy" {
  default = ""
  description = "JSON String with the redrive policy that will be used in the subscription."
}
variable "raw_message_delivery" {
  description = "Whether to enable raw message delivery (the original message is directly passed, not wrapped in JSON with the original message in the message property)"
  default = "false"
}
variable "filter_policy" {
  default = ""
  description = "JSON String with the filter policy that will be used in the subscription to filter messages seen by the target resource."
}
variable "endpoint_auto_confirms" {
  type = bool
  default = false
  description = "Whether the endpoint is capable of auto confirming subscription (e.g., PagerDuty)."
}
variable "confirmation_timeout_in_minutes" {
  type = number
  description = "Integer indicating number of minutes to wait in retrying mode for fetching subscription arn before marking it as failure. Only applicable for http and https protocols."
  default = 1
}
variable "subscription_role_arn" {
  default = null
  description = "ARN of the IAM role to publish to Kinesis Data Firehose delivery stream."
}
