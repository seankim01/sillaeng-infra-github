provider "aws" {
  region  = "ap-northeast-2"
  profile = "mzc-dsa04"
}

resource "aws_s3_bucket" "tfstate" {
  bucket        = "sillaeng-demo-s3-backend"
  force_destroy = true  # 버킷 내 객체가 있어도 삭제 허용
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}
