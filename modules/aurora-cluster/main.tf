resource "aws_rds_cluster" "this" {
  cluster_identifier      = var.cluster_name
  engine                  = var.engine
  engine_version          = var.engine_version
  master_username         = var.username
  master_password         = var.password
  database_name           = var.cluster_name
  backup_retention_period = 7
  preferred_backup_window = "02:00-03:00"
  storage_encrypted       = true
  vpc_security_group_ids  = var.vpc_security_group_ids
  db_subnet_group_name    = aws_db_subnet_group.this.name
  tags                    = var.tags

  deletion_protection = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.cluster_name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_rds_cluster_instance" "this" {
  count                     = 2
  cluster_identifier        = aws_rds_cluster.this.id
  instance_class            = var.instance_class
  publicly_accessible       = false
  tags                      = var.tags
  apply_immediately         = true
  monitoring_interval       = 60
  performance_insights_enabled = true
}

output "aurora_cluster_endpoint" {
  value = aws_rds_cluster.this.endpoint
}

output "reader_endpoint" {
  value = aws_rds_cluster.this.reader_endpoint
}

output "aurora_cluster_arn" {
  value = aws_rds_cluster.this.arn
}
