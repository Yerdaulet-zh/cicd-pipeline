resource "aws_network_acl" "acl" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.project_name}-network-acl"
  }
}

resource "aws_network_acl_rule" "network_acl_tcp_ingress" {
  for_each = {
    22  = 22
    80  = 80
    443 = 443
  }

  network_acl_id = aws_network_acl.acl.id
  rule_number    = each.key
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = each.key
  to_port        = each.value
}

resource "aws_network_acl_rule" "network_acl_tcp_egress" {
  for_each = {
    22  = 22
    80  = 80
    443 = 443
  }

  network_acl_id = aws_network_acl.acl.id
  rule_number    = each.key + 1
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = each.key
  to_port        = each.value
}

resource "aws_network_acl_association" "network_acl_association" {
  subnet_id      = aws_subnet.public.id
  network_acl_id = aws_network_acl.acl.id
}
