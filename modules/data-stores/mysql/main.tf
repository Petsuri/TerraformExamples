provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = var.cluster_name
  username            = "admin1"
  password            = var.db_password
  skip_final_snapshot = true
}

# data "aws_secretsmanager_secret_version" "db_password" {
#   secret_id = "mysql-master-password-stage"
# }

terraform {
  backend "s3" {
    bucket = var.db_remote_state_bucket
    key    = var.db_remote_state_key
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks-petsuri"
    encrypt        = true
  }
}
