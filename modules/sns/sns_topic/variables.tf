variable "sns_topic_name" {
  type = string
  description = "A name for sns topic."
}
variable "delivery_policy" {
  default = ""
  description = "The SNS delivery policy. https://docs.aws.amazon.com/sns/latest/dg/sns-message-delivery-retries.html"
}
variable "sns_topic_policy" {
  description = "The fully-formed AWS policy as JSON. https://learn.hashicorp.com/terraform/aws/iam-policy?_ga=2.230461340.1844696385.1666085929-1969608526.1646213877~"
  default = ""
}
variable "fifo_topic" {
  type = bool
  description = "Boolean indicating whether or not to create a FIFO (first-in-first-out) topic."
  default = null
}

variable "content_based_deduplication" {
  type = bool
  description = "Enables content-based deduplication for FIFO topics."
  default = "false"
}
