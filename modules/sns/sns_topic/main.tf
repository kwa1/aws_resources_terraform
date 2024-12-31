resource "aws_sns_topic" "topic" {
  name                        = var.sns_topic_name
  display_name                = var.sns_topic_name
  delivery_policy             = var.delivery_policy
  policy                      = var.sns_topic_policy
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.fifo_topic != null ? var.content_based_deduplication : false
}
