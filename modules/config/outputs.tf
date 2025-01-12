output "config_delivery_channel_id" {
  description = "The ID of the AWS Config delivery channel."
  value       = aws_config_delivery_channel.main.id
}
