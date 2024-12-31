locals {
  email_identity = "${var.user}@${var.email_domain}"
}

# SES Email Identity Resource
resource "aws_ses_email_identity" "this" {
  email = local.email_identity
  tags  = var.tags
}

# SES Domain Identity (if email is set for the domain)
resource "aws_ses_domain_identity" "this" {
  count  = var.user == null ? 1 : 0
  domain = var.email_domain
  tags   = var.tags
}

# SES DKIM Records
resource "aws_ses_domain_dkim" "this" {
  count  = var.user == null ? 1 : 0
  domain = aws_ses_domain_identity.this[0].domain
}

# Route 53 DNS Records for Email Identity Verification
resource "aws_route53_record" "ses_verification" {
  count   = var.manage_dns_records && var.user == null ? 1 : 0
  zone_id = var.route53_zone_id
  name    = "_amazonses.${var.email_domain}"
  type    = "TXT"
  ttl     = 300
  records = [aws_ses_domain_identity.this[0].verification_token]
}

# Route 53 DKIM CNAME Records for Domain (Optional)
resource "aws_route53_record" "dkim_records" {
  count   = var.manage_dns_records && var.user == null ? length(aws_ses_domain_dkim.this[0].dkim_tokens) : 0
  zone_id = var.route53_zone_id
  name    = "${element(aws_ses_domain_dkim.this[0].dkim_tokens, count.index)}._domainkey.${var.email_domain}"
  type    = "CNAME"
  ttl     = 300
  records = ["${element(aws_ses_domain_dkim.this[0].dkim_tokens, count.index)}.dkim.amazonses.com"]
}

# Optional - Email Identity Verification (for specific email)
resource "aws_ses_email_identity_verification" "this" {
  count  = var.user != null ? 1 : 0
  email  = local.email_identity

  depends_on = [aws_route53_record.ses_verification]
}
