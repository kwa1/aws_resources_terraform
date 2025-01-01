output "secret_arn" {
  description = "ARN of the created secret."
  value       = aws_secretsmanager_secret.this.arn
}

output "kms_key_id" {
  description = "KMS key ID used for encrypting the secret."
  value       = aws_kms_key.secrets_encryption.id
}

output "lambda_function_name" {
  description = "Name of the Lambda function managing rotation."
  value       = aws_lambda_function.rotation_function.function_name
}
