variable "db_username" {
  description = "The AWS region to deploy resources in"
  type        = string
  sensitive   = true
}

variable "postgresql_port" {
  description = "The port on which the PostgreSQL RDS instance will listen"
  type        = number
  sensitive   = true
}

variable "iam_db_user" {
  description = "The IAM database user for connecting to PostgreSQL RDS instance"
  type        = string
  sensitive   = true
}