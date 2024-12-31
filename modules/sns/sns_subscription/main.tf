resource "aws_sns_topic_subscription" "subscription" {
  endpoint                        = var.endpoint
  protocol                        = var.protocol
  topic_arn                       = var.topic_arn
  redrive_policy                  = var.redrive_policy
  raw_message_delivery            = var.raw_message_delivery
  filter_policy                   = var.filter_policy
  endpoint_auto_confirms          = var.endpoint_auto_confirms
  confirmation_timeout_in_minutes = var.confirmation_timeout_in_minutes
  subscription_role_arn           = var.protocol == "firehose" ? var.subscription_role_arn : null
}
