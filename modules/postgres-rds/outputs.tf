output "db_endpoint" {
  description = "The connection endpoint of the PostgreSQL RDS instance"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_identifier" {
  description = "The RDS instance identifier"
  value       = aws_db_instance.this.id
}

output "db_arn" {
  description = "The ARN of the PostgreSQL RDS instance"
  value       = aws_db_instance.this.arn
}

locals {
  tags = merge(
    {
      "Environment" = var.environment,
      "Name"        = var.db_name
    },
    var.tags
  )
}
