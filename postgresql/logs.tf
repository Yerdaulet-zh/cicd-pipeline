resource "aws_cloudwatch_log_group" "rds_logs" {
  for_each = local.log_retention

  # The name MUST follow this exact AWS format for RDS to find it:
  # /aws/rds/instance/<instance-identifier>/<log-type>
  name              = "/aws/rds/instance/${local.postresql_identifier}/${each.key}"
  retention_in_days = each.value

  tags = {
    Project = "Enterprise-Free-Tier"
  }
}
