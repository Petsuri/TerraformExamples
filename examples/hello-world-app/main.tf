provider "aws" {
  region = "us-east-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

module "hello_world_app" {
  source = "../../modules/services/hello-world-app"

  server_text = "Hello, Petsuri"
  environment = "example"

  # Pass all the outputs from the mysql module straight through!
  # mysql_config = module.mysql

  mysql_config = var.mysql_config

  db_remote_state_bucket = "terraform-up-and-running-state-petsuri"
  db_remote_state_key    = "examples/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false
}

# module "mysql" {
#   source = "../../modules/data-stores/mysql"

#   db_name     = var.db_name
#   db_username = var.db_username
#   db_password = db_password
# }
