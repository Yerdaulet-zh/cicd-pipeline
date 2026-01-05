terraform {
  backend "s3" {
    bucket       = "my-terraform-state-bucket-rag"
    key          = "networking/vpc/cicd_epam_hw/terraform.tfstate"
    region       = "eu-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
