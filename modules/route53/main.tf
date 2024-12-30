resource "aws_route53_zone" "this" {
  name = var.domain_name

  # Optional: If it's a private hosted zone, uncomment and set the VPC
  vpc_id = var.vpc_id != "" ? var.vpc_id : null

  tags = var.zone_tags
}

resource "aws_route53_record" "this" {
  for_each = var.subdomains

  zone_id = aws_route53_zone.this.id
  name    = "${each.key}.${var.domain_name}"
  type    = each.value

  # Conditional for different record types
  ttl     = 300

  dynamic "records" {
    for_each = each.value == "A" ? [var.acm_certificate_arn] : []
    content {
      # Example A record for an IP or ALB (to be replaced with actual resource)
      value = "ALB-Endpoint-or-IP"
    }
  }

  dynamic "alias" {
    for_each = each.value == "A" ? [1] : []
    content {
      name                   = "your-alb-dns-name"
      zone_id                = "your-alb-zone-id"
      evaluate_target_health = true
    }
  }

  dynamic "records" {
    for_each = each.value == "CNAME" ? [1] : []
    content {
      value = "cname-target.example.com"
    }
  }
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = var.acm_certificate_arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]
}
