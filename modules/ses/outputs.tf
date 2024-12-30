output "domain_identity_arn" {
  description = "The ARN of the domain identity (if applicable)"
  value       = aws_ses_domain_identity.this[0].arn
}

output "email_identity" {
  description = "The SES email identity (if configured)"
  value       = var.email_identity != null ? aws_ses_email_identity.this[0].email : null
}

output "dkim_tokens" {
  description = "The DKIM tokens for the domain (if applicable)"
  value       = var.email_identity == null ? aws_ses_domain_dkim.this[0].dkim_tokens : []
}
