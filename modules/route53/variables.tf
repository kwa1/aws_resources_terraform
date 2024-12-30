# Route 53 and ACM Module Variables

variable "domain_name" {
  type        = string
  description = "The main domain name (e.g., sakano.com)."
}

variable "acm_certificate_arn" {
  type        = string
  description = "The ARN of the already issued ACM certificate."
}

variable "subdomains" {
  type        = map(string)
  description = "Map of subdomains and their corresponding record types (A, CNAME, etc.)."
}

variable "zone_tags" {
  type        = map(string)
  description = "Tags to apply to the hosted zone."
  default     = {}
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for private hosted zones (if applicable)."
  default     = ""
}
