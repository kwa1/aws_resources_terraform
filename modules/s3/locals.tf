locals {
  # Determine if the bucket should be created
  create_bucket = var.create_bucket && var.enable_bucket_creation

  # Aggregate conditions for policy attachments
  attach_policy = var.attach_require_latest_tls_policy || var.attach_elb_log_delivery_policy || var.attach_lb_log_delivery_policy || var.attach_deny_insecure_transport_policy || var.attach_policy

  # Decode inputs if provided as JSON strings
  grants          = try(jsondecode(var.grant), var.grant)
  cors_rules      = try(jsondecode(var.cors_rule), var.cors_rule)
  lifecycle_rules = try(jsondecode(var.lifecycle_rule), var.lifecycle_rule)

  # Combine default and custom tags
  default_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
  combined_tags = merge(local.default_tags, var.tags)
}
