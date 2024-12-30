resource "aws_db_subnet_group" "this" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_db_instance" "this" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  name                   = var.db_name
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = false
  storage_encrypted      = true
  backup_retention_period = 7
  deletion_protection     = true
  multi_az               = false
  tags                   = var.tags

  monitoring_interval = 60
  performance_insights_enabled = true

  lifecycle {
    prevent_destroy = true
  }
}

output "db_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "db_arn" {
  value = aws_db_instance.this.arn
}
