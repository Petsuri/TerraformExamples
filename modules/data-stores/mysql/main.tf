terraform {
  # Require any 0.12.x version of terraform
  required_version = ">= 0.12, < 0.13"
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
