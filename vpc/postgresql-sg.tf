resource "aws_security_group" "posgres" {
  name        = "postgresql-sg"
  description = "Security group for PostgreSQL RDS instance"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.sonarqube.id]
  }

  # Define an egress (outbound) rule.
  # Without this, your DB cannot respond to requests or reach out for updates.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PostgreSQL-SG"
  }
}

resource "aws_db_subnet_group" "postgresql_private" {
  name       = "free-tier-postgresql-private-subnet-group"
  subnet_ids = [for subnet in aws_subnet.private : subnet.id]
}
