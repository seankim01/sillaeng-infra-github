terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 5.0"
      version = "~> 6.24.0"      
    }
  }

  backend "s3" {
    profile      = "mzc-dsa04"
    bucket       = "sillaeng-demo-s3-backend"
    key          = "demo/network/terraform.tfstate"
    region       = "ap-northeast-2"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region  = "ap-northeast-2"
  profile = "mzc-dsa04"

  # default_tags {
  #   tags = {
  #     User = "jigreg" # Replace with your name
  #   }
  # }
}
#   backend "s3" {
#     profile        = "team"
#     bucket         = "jigreg"
#     key            = "dr/network/terraform.tfstate"
#     region         = "ap-northeast-2"
#     encrypt        = true
#     dynamodb_table = "seojun-terraform-lock"
#     acl            = "bucket-owner-full-control"
#   }
# }

# provider "aws" {
#   region  = "ap-northeast-2"
#   profile = "team"

#   default_tags {
#     tags = {
#       User = "jigreg"
#     }
#   }
# }


