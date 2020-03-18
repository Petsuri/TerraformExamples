provider "aws" {
  region = "us-east-2"
}

module "mysql" {
  source = "../../../../modules/data-stores/mysql"

  db_password  = ""
  cluster_name = "webserversprod"
}

terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-petsuri"
    key    = "prod/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks-petsuri"
    encrypt        = true
  }
}
