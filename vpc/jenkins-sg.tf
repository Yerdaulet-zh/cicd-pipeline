resource "aws_security_group" "jenkins" {
  name   = "${local.project_name}-jenkins-sg"
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "jenkins-sg"
  }
}

resource "aws_security_group_rule" "jenkins_ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins.id
}

resource "aws_security_group_rule" "jenkins_ingress_from_nginx" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nginx.id # Links to Nginx
  security_group_id        = aws_security_group.jenkins.id
}

resource "aws_security_group_rule" "jenkins_ingress_public" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins.id
}

resource "aws_security_group_rule" "jenkins_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins.id
}
