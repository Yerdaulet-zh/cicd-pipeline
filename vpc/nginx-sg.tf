resource "aws_security_group" "nginx" {
  name   = "${local.project_name}-nginx-sg"
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "nginx-sg" }
}

resource "aws_security_group_rule" "nginx_ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nginx.id
}

# resource "aws_security_group_rule" "nginx_ingress_http" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.nginx.id
# }

resource "aws_security_group_rule" "nginx_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nginx.id
}

resource "aws_security_group_rule" "nginx_egress_to_jenkins" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.jenkins.id # Links to Jenkins
  security_group_id        = aws_security_group.nginx.id
}

resource "aws_security_group_rule" "nginx_egress_to_sonarqube" {
  type                     = "egress"
  from_port                = 9000
  to_port                  = 9000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sonarqube.id
  security_group_id        = aws_security_group.nginx.id
}

resource "aws_security_group_rule" "nginx_egress_to_internet" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nginx.id
}
