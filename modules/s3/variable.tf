# AWS Region
variable "aws_region" {
  description = "AWS region for resources."
  type        = string
  default     = "us-east-1"
}

# Bucket configuration
variable "bucket" {
  description = "Name of the S3 bucket."
  type        = string
}

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name."
  type        = string
  default     = null
}

# Tags
variable "tags" {
  description = "Custom tags for resources."
  type        = map(string)
  default     = {}
}

# Logging configuration
variable "logging" {
  description = "Logging configuration for the S3 bucket."
  type        = map(string)
  default     = {}
}

# JSON-encoded values (optional inputs)
variable "grant" {
  description = "JSON-encoded bucket grants."
  type        = any
  default     = null
}

variable "cors_rule" {
  description = "JSON-encoded CORS rules."
  type        = any
  default     = null
}

variable "lifecycle_rule" {
  description = "JSON-encoded lifecycle rules."
  type        = any
  default     = null
}

# Feature toggles
variable "create_bucket" {
  description = "Whether to create the S3 bucket."
  type        = bool
  default     = true
}

variable "enable_bucket_creation" {
  description = "Additional toggle to control bucket creation."
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Force destroy bucket contents on deletion."
  type        = bool
  default     = false
}

variable "object_lock_enabled" {
  description = "Enable object lock for WORM compliance."
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment for tagging (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

# Policy attachment toggles
variable "attach_require_latest_tls_policy" {
  description = "Attach a policy requiring latest TLS."
  type        = bool
  default     = false
}

variable "attach_elb_log_delivery_policy" {
  description = "Attach policy for ELB log delivery."
  type        = bool
  default     = false
}

variable "attach_lb_log_delivery_policy" {
  description = "Attach policy for LB log delivery."
  type        = bool
  default     = false
}

variable "attach_deny_insecure_transport_policy" {
  description = "Attach policy to deny insecure transport."
  type        = bool
  default     = false
}

variable "attach_policy" {
  description = "Attach a custom policy to the bucket."
  type        = bool
  default     = false
}
