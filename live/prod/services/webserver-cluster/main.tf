terraform {
  required_version = "= 0.12.23"
}

provider "aws" {
  region = "us-east-2"

  # Allow any 2.x version of the AWS provider
  verson = "~> 2.0"
}

module "webserver_cluster" {
  source = "../../../../modules/services/hello-world-app"

  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "terraform-up-and-running-state-petsuri"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 10

  enable_autoscaling = true

  custom_tags = {
    Owner      = "Petsuri"
    DeployedBy = "Terraform"
  }
}
