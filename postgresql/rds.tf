resource "aws_db_instance" "postgresql_instance" {
  identifier               = local.postresql_identifier
  engine                   = local.engine
  engine_version           = local.engine_version
  engine_lifecycle_support = local.engine_lifecycle_support
  instance_class           = local.instance_class
  deletion_protection      = true

  # Storage
  storage_type          = local.storage_type
  storage_encrypted     = local.storage_encrypted
  allocated_storage     = local.allocated_storage_gb
  max_allocated_storage = local.max_allocated_storage_gb
  # iops                  = local.iops
  # storage_throughput    = local.storage_throughput

  # Credentials (Password is managed by AWS Secrets Manager automatically if set)
  manage_master_user_password         = true
  username                            = var.db_username
  iam_database_authentication_enabled = false

  # Networking
  db_subnet_group_name   = data.aws_db_subnet_group.private_subnet_group.name
  vpc_security_group_ids = [data.aws_security_group.rds_sg.id]
  multi_az               = false
  publicly_accessible    = false
  network_type           = "IPV4"
  port                   = var.postgresql_port
  ca_cert_identifier     = local.ca_cert_identifier

  # Maintenance & Backups
  backup_retention_period    = local.backup_retention_period
  backup_window              = local.backup_window
  maintenance_window         = local.maintenance_window
  copy_tags_to_snapshot      = true
  auto_minor_version_upgrade = true
  delete_automated_backups   = false
  skip_final_snapshot        = false
  final_snapshot_identifier  = local.final_snapshot_identifier

  # Monitoring (OS Metrics)
  monitoring_role_arn = aws_iam_role.rds_monitoring.arn
  monitoring_interval = local.monitoring_interval # in seconds

  # Performance Insights
  performance_insights_enabled          = true
  performance_insights_retention_period = local.performance_insights_retention_period
  performance_insights_kms_key_id       = local.performance_insights_kms_key_id

  database_insights_mode = local.database_insights_mode

  # Log Exports
  enabled_cloudwatch_logs_exports = local.enabled_cloudwatch_logs_exports

  # Parameter Group
  parameter_group_name = aws_db_parameter_group.postgres_optimized.name

  timeouts {
    create = "60m"
    delete = "2h"
    update = "80m"
  }

  tags = {
    Name = "Free Tier PostgreSQL 17.6-R2 Instance"
  }
}
