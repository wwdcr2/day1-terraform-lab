
provider "aws" {
  region  = "ap-northeast-2"
  profile = "hoseong"
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "terraform-1mzregla"
    key          = "training/main/terraform.tfstate"
    region       = "ap-northeast-2"
    use_lockfile = true
    # dynamodb_table = "terraform-lock"
  }
}


# resource "aws_dynamodb_table" "terraform_state_lock" {
#   name           = "terraform-lock"
#   hash_key       = "LockID"
#   billing_mode   = "PAY_PER_REQUEST"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }
