variable "user" {
  description = "Email user prefix (e.g., noreply)"
  type        = string
}

variable "email_domain" {
  description = "The domain for the email identity (e.g., sakano.com)"
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
