# SES Domain Identity (if domain is provided)
resource "aws_ses_domain_identity" "this" {
  count  = var.email_identity == null ? 1 : 0
  domain = var.domain_name
  tags   = var.tags
}

# SES Email Identity (if email_identity is provided)
resource "aws_ses_email_identity" "this" {
  count = var.email_identity != null ? 1 : 0
  email = var.email_identity
}

# DKIM for Domain Identity
resource "aws_ses_domain_dkim" "this" {
  count  = var.email_identity == null ? 1 : 0
  domain = aws_ses_domain_identity.this[0].domain
}

# SES Domain Verification Token DNS Record (Optional)
resource "aws_route53_record" "ses_verification" {
  count   = var.manage_dns_records && var.email_identity == null ? 1 : 0
  zone_id = var.route53_zone_id
  name    = "_amazonses.${var.domain_name}"
  type    = "TXT"
  ttl     = 300
  records = [aws_ses_domain_identity.this[0].verification_token]
}

# DKIM CNAME Records for Domain (Optional)
resource "aws_route53_record" "dkim_records" {
  count   = var.manage_dns_records && var.email_identity == null ? length(aws_ses_domain_dkim.this[0].dkim_tokens) : 0
  zone_id = var.route53_zone_id
  name    = "${element(aws_ses_domain_dkim.this[0].dkim_tokens, count.index)}._domainkey.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = ["${element(aws_ses_domain_dkim.this[0].dkim_tokens, count.index)}.dkim.amazonses.com"]
}

# SES Domain Identity Verification
resource "aws_ses_domain_identity_verification" "this" {
  count  = var.email_identity == null ? 1 : 0
  domain = aws_ses_domain_identity.this[0].domain

  depends_on = [aws_route53_record.ses_verification]
}
