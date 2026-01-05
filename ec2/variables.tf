variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be deployed"
  type        = string
  sensitive   = true
}

variable "sg_nginx_id" {
  description = "The security group ID for the Nginx server"
  type        = string
  sensitive   = true
}

variable "sg_jenkins_id" {
  description = "The security group ID for the Jenkins server"
  type        = string
  sensitive   = true
}

variable "ssh_key_pair_name" {
  description = "The name of the SSH key pair to access the EC2 instance"
  type        = string
  sensitive   = true
}
