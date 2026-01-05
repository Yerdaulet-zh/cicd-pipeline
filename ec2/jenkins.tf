resource "aws_instance" "jenkins_instance" {
  ami                    = local.server_ami
  instance_type          = "t3.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_jenkins_id]
  key_name               = var.ssh_key_pair_name
  private_ip             = local.jenkins_private_ip

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update && sudo apt upgrade -y 
              EOF

  tags = {
    Name = "Jenkins"
  }
}
