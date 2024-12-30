variable "domain_name" {
  description = "The domain name to configure with SES"
  type        = string
}

variable "region" {
  description = "AWS region where SES should be configured"
  type        = string
}

variable "route53_zone_id" {
  description = "The Route 53 hosted zone ID for the domain"
  type        = string
  default     = null
}

variable "email_identity" {
  description = "Optional email address for SES identity (useful if pre-verified)"
  type        = string
  default     = null
}

variable "manage_dns_records" {
  description = "Flag to control whether Route 53 records should be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}
