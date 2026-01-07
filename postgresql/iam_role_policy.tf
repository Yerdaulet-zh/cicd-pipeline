# IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring" {
  name = local.rds_monitoring_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# # IAM Policy to allow EC2 instance to connect to RDS using IAM Authentication
# resource "aws_iam_policy" "rds_connect_policy" {
#   name        = "RDS-IAM-Connect-Policy"
#   description = "Allows EC2 instance to connect to Postgres via IAM Auth"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action   = "rds-db:connect"
#         Effect   = "Allow"
#         # Format: arn:aws:rds-db:region:account-id:dbuser:db-resource-id/database_user_name
#         # The "*" allows connection to any user, but for enterprise, we specify the DB user.
#         Resource = "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:dbuser:${aws_db_instance.postgresql_instance.resource_id}/${var.iam_db_user}"
#       }
#     ]
#   })
# }

# # Attach this policy to your EC2 Instance Role
# resource "aws_iam_role_policy_attachment" "bastion_rds_attach" {
#   role       = aws_iam_role.bastion_role.name # The role attached to your EC2
#   policy_arn = aws_iam_policy.rds_connect_policy.arn
# }
