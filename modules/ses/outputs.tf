output "email_identity" {
  description = "The verified SES email identity"
  value       = local.email_identity
}

output "verification_token" {
  description = "The SES verification token for the email identity"
  value       = aws_ses_email_identity.this.verification_token
}

output "dkim_tokens" {
  description = "The DKIM tokens for the domain (if applicable)"
  value       = var.user == null ? aws_ses_domain_dkim.this[0].dkim_tokens : []
}
