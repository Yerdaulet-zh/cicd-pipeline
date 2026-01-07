resource "aws_instance" "sonarqube_instance" {
  ami                    = local.server_ami
  instance_type          = "t3.medium"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_sonarqube_id]
  private_ip             = local.sonarqube_private_ip
  key_name               = var.ssh_key_pair_name

  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    iops        = 3000
    throughput  = 125
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update && sudo apt upgrade -y
              # Install dependencies for Postgres and SonarQube
              sudo apt install -y postgresql-common openjdk-17-jdk
              EOF

  tags = {
    Name = "Sonarqube-Server"
  }
}
