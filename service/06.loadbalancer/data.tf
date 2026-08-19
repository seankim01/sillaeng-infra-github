data "terraform_remote_state" "remote" {         # provider.tf 참조
  backend = "s3"
  config = {
    bucket  = "sillaeng-demo-s3-backend"  # State가 저장된 버킷
    key     = "dr/network/terraform.tfstate"     # 네트워크 state파일 경로
    region  = "ap-northeast-2"
    profile = "mzc-dsa04"
  }
}

data "terraform_remote_state" "remote_ec2" {     # provider.tf 참조
  backend = "s3"
  config = {
    bucket  = "sillaeng-demo-s3-backend"  # State가 저장된 버킷
    key     = "dr/ec2/terraform.tfstate"         # 네트워크 state파일 경로
    region  = "ap-northeast-2"
    profile = "mzc-dsa04"
  }
}
# data "terraform_remote_state" "remote" { # provider.tf 참조
#   backend = "s3"
#   config = {
#     bucket  = "jigreg"                       # 고객사 버킷으로 변경해야합니다.
#     key     = "dr/network/terraform.tfstate" # 고객사 키 값으로 변경해야합니다. 네트워크 state파일 경로
#     region  = "ap-northeast-2"
#     profile = "team"
#   }
# }
# data "terraform_remote_state" "remote_ec2" { # provider.tf 참조
#   backend = "s3"
#   config = {
#     bucket  = "jigreg"                   # 고객사 버킷으로 변경해야합니다.
#     key     = "dr/ec2/terraform.tfstate" # 고객사 키 값으로 변경해야합니다. 네트워크 state파일 경로
#     region  = "ap-northeast-2"
#     profile = "team"
#   }
# }

