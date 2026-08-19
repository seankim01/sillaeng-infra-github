provider "aws" {
  region  = "ap-northeast-2"
  profile = "mzc-dsa04"
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "sillaeng-demo-s3-backend"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}
