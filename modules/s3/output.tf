output "bucket_name" {
  description = "The name of the created S3 bucket."
  value       = aws_s3_bucket.this[0].bucket
  condition   = local.create_bucket
}

output "bucket_arn" {
  description = "The ARN of the created S3 bucket."
  value       = aws_s3_bucket.this[0].arn
  condition   = local.create_bucket
}

output "logging_target_bucket" {
  description = "The bucket where access logs are stored."
  value       = var.logging["target_bucket"]
  condition   = local.create_bucket && length(keys(var.logging)) > 0
}
