output "client_id" {
  description = "The ID of the created Cognito user pool client."
  value       = aws_cognito_user_pool_client.client.id
}

output "client_name" {
  description = "The name of the created Cognito user pool client."
  value       = aws_cognito_user_pool_client.client.name
}

output "client_secret" {
  description = "The secret of the created Cognito user pool client, if generated."
  value       = aws_cognito_user_pool_client.client.client_secret
  condition   = var.generate_secret
}
