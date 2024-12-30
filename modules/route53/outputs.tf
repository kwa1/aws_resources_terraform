output "route53_zone_id" {
  description = "The Route 53 Hosted Zone ID."
  value       = aws_route53_zone.this.id
}

output "route53_zone_name" {
  description = "The Route 53 Hosted Zone Name."
  value       = aws_route53_zone.this.name
}

output "subdomain_records" {
  description = "Map of subdomains and their DNS records."
  value       = aws_route53_record.this
}
