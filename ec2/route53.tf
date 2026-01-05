data "aws_route53_zone" "selected" {
  name         = "beeapp-stt-ai-endpoint.com."
  private_zone = false
}

resource "aws_route53_record" "nginx" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "epam-cicd.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = 300

  # This links to the public_ip attribute of your EIP resource
  records = [aws_eip.nginx_static_ip.public_ip]
}
