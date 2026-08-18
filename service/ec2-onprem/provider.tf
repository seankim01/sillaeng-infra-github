terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 5.0"
      version = "~> 6.24.0"   
    }
  }

  backend "s3" {
    profile = "mzc-dsa04"  
    bucket         = "sillaeng-demo-s3-backend"
    key            = "idc/ec2-onpremise/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "sillaeng-demo-dynamodb-tfstate"
    acl            = "bucket-owner-full-control"
  }
}

provider "aws" {
  region  = "ap-northeast-2"
  profile = "mzc-dsa04"  
}