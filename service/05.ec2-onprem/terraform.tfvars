ec2_create = [

  {
    index                  = "bundang-ec2-public-bastion"
    ami                    = "ami-0cde067c44daf99fc" # Amazon Linux 2 AMI - Seoul (2026-08-17)
    instance_type          = "t3.medium"
    sub_index              = "bundang-pub-01a"
    sg_index               = ["bundang-public-bastion-ec2"]
    key_name               = "mzc-dsa04-shared"
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = true
    user_data              = "userdata/openswan_userdata.sh" # Openswan VPN 설치 스크립트
    instance_profile_index = "ssm"
    eni_required           = false
    source_dest_check      = false                          # VPN 트래픽 라우팅을 위해 반드시 false
    network_boundary       = "pub"
    purpose                = "public-bastion"
    service                = "bundang"
    region_az              = "apne2a"
    type                   = "ec2"
  },

  {
    index                  = "bundang-ec2-private-bastion"
    ami                    = "ami-0b818a04bc9c2133c" # Seoul Amazon Linux 2023 AMI 2023.9.20251208.0 x86_64 HVM kernel-6.1
    instance_type          = "t3.medium"
    sub_index              = "bundang-pri-01a"
    sg_index               = ["bundang-private-bastion-ec2"]
    key_name               = "mzc-dsa04-shared"
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = false
    user_data              = "userdata/example_userdata.sh"
    instance_profile_index = "ssm"
    eni_required           = false
    network_boundary       = "private"
    purpose                = "private-bastion"
    service                = "bundang"
    region_az              = "apne2a"
    type                   = "ec2"
  },

]

iam_create = [
  {
    index   = "ssm"
    purpose = "mng"
  }
]

iam_policy_create = [

]

iam_policy_attach = [
  {
    index      = "mng-attach"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
    iam_index  = "ssm"
  }
]
