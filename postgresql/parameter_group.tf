resource "aws_db_parameter_group" "postgres_optimized" {
  name        = "postgres17-6-full-config"
  family      = "postgres17"
  description = "Complete parameter group with explicit defaults and tuning"

  # --- Performance & Memory ---
  parameter {
    name  = "work_mem"
    value = "16384" # 16MB
  }

  parameter {
    name  = "effective_cache_size"
    value = "{DBInstanceClassMemory/16384}" # AWS formula for disk cache hint
  }

  # --- Operational ---
  parameter {
    name  = "autovacuum"
    value = "on"
  }

  parameter {
    name  = "max_wal_size"
    value = "1024" # 1GB
  }

  parameter {
    name  = "checkpoint_timeout"
    value = "300"
  }

  #   parameter {
  #     name  = "lock_timeout"
  #     value = "0" # Disabled
  #   }

  parameter {
    name  = "idle_in_transaction_session_timeout"
    value = "86400000" # 24 hours
  }

  # --- Enhanced Logging ---
  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  parameter {
    name  = "log_statement"
    value = "ddl" # Logs all data definition queries
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "500" # Log queries slower than 500ms
  }

  # --- Extensions & Static Params ---
  parameter {
    name         = "shared_preload_libraries"
    value        = "pg_stat_statements"
    apply_method = "pending-reboot"
  }

  tags = {
    Name      = "PostgresFullConfig"
    ManagedBy = "Terraform"
  }
}
