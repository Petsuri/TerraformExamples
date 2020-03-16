provider "aws" {
  region = "us-east-2"
}

module "mysql" {
  source = "../../../modules/data-stores/mysql"

  db_password            = ""
  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-petsuri"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
}
