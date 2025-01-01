output "identity_pool_id" {
  description = "The ID of the created Cognito Identity Pool."
  value       = aws_cognito_identity_pool.example_provider.id
}

output "identity_pool_name" {
  description = "The name of the created Cognito Identity Pool."
  value       = aws_cognito_identity_pool.example_provider.identity_pool_name
}
