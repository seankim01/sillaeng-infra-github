data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket  = "sillaeng-demo-s3-backend"
    key     = "demo/network/terraform.tfstate"
    region  = "ap-northeast-2"
    profile = "mzc-dsa04"
  }
}

data "terraform_remote_state" "remote_ec2" {
  backend = "s3"
  config = {
    bucket  = "sillaeng-demo-s3-backend"
    key     = "demo/ec2/terraform.tfstate"
    region  = "ap-northeast-2"
    profile = "mzc-dsa04"
  }
}
