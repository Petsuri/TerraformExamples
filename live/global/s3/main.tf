provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state-petsuri"

  # # Prevent accidental deletion of this S3 bucket
  # lifecycle {
  #     prevent_destroy = true
  # }

  # Enable versioning so we can see the full revision history of our state files
  versioning {
    enabled = true
  }

  region = "us-east-2"

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks-petsuri"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# resource "aws_instance" "example" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = terraform.workspace == "default" ? "t2.micro" : "t2.micro"
# }


# Partial configuration. The other settings (e.g. bucket, region) will be passed in from a file
# via -backend-config arguments to 'terraform init'
# terraform {
#   backend "s3" {
#     bucket = "terraform-up-and-running-state-petsuri"
#     key    = "workspaces-example/terraform.tfstate"
#     region = "us-east-2"

#     dynamodb_table = "terraform-up-and-running-locks-petsuri"
#     encrypt        = true
#   }
# }
