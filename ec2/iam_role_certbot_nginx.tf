resource "aws_iam_role" "nginx_role" {
  name = "nginx-certbot-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "certbot_route53" {
  name        = "CertbotRoute53Access"
  description = "Allows Certbot to manage DNS-01 challenges for EPAM CICD"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["route53:ListHostedZones", "route53:GetChange"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = "route53:ChangeResourceRecordSets"
        Effect   = "Allow"
        Resource = "arn:aws:route53:::hostedzone/${data.aws_route53_zone.selected.zone_id}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "certbot_attach" {
  role       = aws_iam_role.nginx_role.name
  policy_arn = aws_iam_policy.certbot_route53.arn
}

resource "aws_iam_instance_profile" "nginx_profile" {
  name = "nginx-instance-profile"
  role = aws_iam_role.nginx_role.name
}
