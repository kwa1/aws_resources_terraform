terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_canonical_user_id" "this" {}

resource "aws_s3_bucket" "this" {
  count = local.create_bucket ? 1 : 0

  bucket        = var.bucket
  bucket_prefix = var.bucket_prefix

  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled
  tags                = local.combined_tags

  lifecycle {
    ignore_changes = [
      acl,
      grant,
      cors_rule,
      lifecycle_rule,
      logging,
      object_lock_configuration,
      replication_configuration,
      request_payer,
      server_side_encryption_configuration,
      versioning,
      website
    ]
  }
}

resource "aws_s3_bucket_logging" "this" {
  count = local.create_bucket && length(keys(var.logging)) > 0 ? 1 : 0

  bucket        = aws_s3_bucket.this[0].id
  target_bucket = var.logging["target_bucket"]
  target_prefix = try(var.logging["target_prefix"], null)
}
