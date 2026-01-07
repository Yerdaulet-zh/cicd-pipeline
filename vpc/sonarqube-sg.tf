resource "aws_security_group" "sonarqube" {
    name = "${local.project_name}-sonarqube-sg"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "sonarqube-sg"
    }  
}

resource "aws_security_group_rule" "sonarqube_ingress_http" {
    type = "ingress"
    from_port = 9000
    to_port = 9000
    protocol = "tcp"
    source_security_group_id = [aws_security_group.nginx.id]
    security_group_id = aws_security_group.sonarqube.id
}

resource "aws_security_group_rule" "sonarqube_egress_to_internet" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.sonarqube.id
}

