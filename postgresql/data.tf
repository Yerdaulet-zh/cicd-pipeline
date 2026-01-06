data "aws_security_group" "rds_sg" {
  filter {
    name   = "group-name"
    values = ["postgresql-sg"]
  }
}

data "aws_db_subnet_group" "private_subnet_group" {
  name = "free-tier-postgresql-private-subnet-group"
}
