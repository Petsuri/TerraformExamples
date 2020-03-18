provider "aws" {
  region = "us-east-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

module "webserver_cluster" {
  source = "../../../../modules/services/hello-world-app"

  #source = "github.com/Petsuri/TerraformExamples//modules/services/hello-world-app?ref=v0.0.51"

  ami         = "ami-0c55b159cbfafe1f0"
  server_text = "Petsuri's new server"

  environment            = "stage"
  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-petsuri"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2

  enable_autoscaling = false

  custom_tags = {
    Owner      = "Petsuri"
    DeployedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "allow_testing_inboud" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
