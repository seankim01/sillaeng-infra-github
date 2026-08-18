provider "aws" {
  region = "ap-northeast-2"
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

resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "sillaeng-demo-dynamodb-tfstate"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
