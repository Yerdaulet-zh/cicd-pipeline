locals {
  engine                   = "postgres"
  engine_version           = "17.6"
  engine_lifecycle_support = "open-source-rds-extended-support"
  instance_class           = "db.t4g.micro"
  rds_monitoring_role_name = "rds-free-tier-postgresql-monitoring-role"
  postresql_identifier     = "free-tier-postgresql"

  # Storage
  allocated_storage_gb     = 20
  max_allocated_storage_gb = 25
  storage_type             = "gp3"
  iops                     = 3000 # Baseline for gp3
  storage_throughput       = 125  # Baseline for gp3
  storage_encrypted        = true

  # Networking
  ca_cert_identifier = "rds-ca-ecc384-g1" # Expires May 25, 2121

  # Maintenance & Backups
  backup_retention_period   = 7
  backup_window             = "19:00-20:00"
  maintenance_window        = "sun:22:00-sun:23:00"
  final_snapshot_identifier = "${local.postresql_identifier}-final-snapshot"

  # Monitoring (OS Metrics)
  monitoring_interval = 60 # in seconds

  # Performance Insights
  performance_insights_retention_period = 7
  performance_insights_kms_key_id       = ""
  database_insights_mode                = "standard"

  # Logs
  enabled_cloudwatch_logs_exports = ["iam-db-auth-error", "postgresql", "upgrade"]
  log_retention = {
    "postgresql"        = 30 # Keep engine logs for 30 days
    "upgrade"           = 14 # Keep upgrade logs for 2 weeks
    "iam-db-auth-error" = 90 # Keep security/auth logs longer (90 days)
  }
}
