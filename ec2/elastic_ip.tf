resource "aws_eip" "nginx_static_ip" {
  domain = "vpc"
  tags = {
    Name = "nginx-static-ip"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.nginx_instance.id
  allocation_id = aws_eip.nginx_static_ip.id
}
