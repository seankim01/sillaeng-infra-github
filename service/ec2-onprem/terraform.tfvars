ec2_create = [

  {
    index                  = "bundang-ec2-public-bastion"
    #ami                    = "ami-07b70db997adb22fb" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04)
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI - Seoul 
    #ami                    = "ami-0d4a6b537cb9bdca1" # Amazon Linux 2 AMI - Tokyo / (AWS Marketplace AMIs) Amazon Linux 2 AMI 2.0.20251121.0 x86_64 HVM gp2
    #ami                    = "ami-06000b1a9ad0ea6ca" # Amazon Linux 2 AMI - Tokyo / Installed OpenSwan (AWS Marketplace AMIs) Amazon Linux 2 AMI 2.0.20251121.0 x86_64 HVM gp2    
    #ami                    = "ami-0342940824bf826ee" # Amazon Linux 2 AMI - Tokyo / hsfms-idc-nonhyeon-public-251211
    ami                    = "ami-0ddff5b95628dbb7c" # Amazon Linux 2 AMI - Seoul / hsfms-idc-bundang-public-20251210
    instance_type          = "t3.medium"
    sub_index              = "bundang-pub-01a"   # subnet 변수 값을 넣어주세요
    sg_index               = ["bundang-public-bastion-ec2"] # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"      # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = true                           # eip 필요 시 에 기입
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"                          # ec2 롤 부여시 기입 현재 SSM Role만 부여
    eni_required           = false                          # private ip 따로 지정해서 사용 안할 시에 False
    network_boundary = "pub"
    purpose          = "public-bastion"
    service          = "bundang"
    region_az        = "apne2a"
    type             = "ec2"
  },

  {
    index                  = "bundang-ec2-private-bastion"
    #ami                    = "ami-07b70db997adb22fb" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04)
    #ami                    = "ami-002619f9bb1f83273" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04) + CDK 사전 설치 AMI 11/10    
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI
    #ami                    = "ami-0d4a6b537cb9bdca1" # Amazon Linux 2 AMI - Tokyo / (AWS Marketplace AMIs) Amazon Linux 2 AMI 2.0.20251121.0 x86_64 HVM gp2
    ##ami                    = "ami-06000b1a9ad0ea6ca" # Amazon Linux 2 AMI - Tokyo / Installed OpenSwan (AWS Marketplace AMIs) Amazon Linux 2 AMI 2.0.20251121.0 x86_64 HVM gp2        
    ami                    = "ami-0b818a04bc9c2133c" # Seoul Amazon Linux 2023 AMI 2023.9.20251208.0 x86_64 HVM kernel-6.1
    instance_type          = "t3.medium"
    sub_index              = "bundang-pri-01a"   # subnet 변수 값을 넣어주세요
    sg_index               = ["bundang-private-bastion-ec2"] # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"      # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = false                          # eip 필요 시 에 기입
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"                          # ec2 롤 부여시 기입 현재 SSM Role만 부여
    eni_required           = false                          # private ip 따로 지정해서 사용 안할 시에 False
    network_boundary = "private"
    purpose          = "private-bastion"
    service          = "bundang"
    region_az        = "apne2a"
    type             = "ec2"
  },

  {
    index                  = "nonhyeon-ec2-public-bastion"
    #ami                    = "ami-07b70db997adb22fb" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04)
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI - Seoul 
    #ami                    = "ami-0d4a6b537cb9bdca1" # Amazon Linux 2 AMI - Tokyo / (AWS Marketplace AMIs) Amazon Linux 2 AMI 2.0.20251121.0 x86_64 HVM gp2
    #ami                    = "ami-06000b1a9ad0ea6ca" # Amazon Linux 2 AMI - Tokyo / Installed OpenSwan (AWS Marketplace AMIs) Amazon Linux 2 AMI 2.0.20251121.0 x86_64 HVM gp2    
    #ami                    = "ami-0342940824bf826ee" # Amazon Linux 2 AMI - Tokyo / hsfms-idc-nonhyeon-public-251211
    #ami                    = "ami-0d4a6b537cb9bdca1"  # Amazon Linux 2 AMI (HVM), SSD Volume Type (64-bit x86) Operating System / amzn2-ami-hvm-2.0.20251121.0-x86_64-gp2 / Amazon Linux 2 AMI 2.0.20251121.0 x86_64 HVM gp2
    ami                    = "ami-0d15b634a1132d893" # Amazon Linux 2 AMI - Seoul / hsfms-idc-nonhyeon-public-20251211
    instance_type          = "t3.medium"
    sub_index              = "nonhyeon-pub-01a"   # subnet 변수 값을 넣어주세요
    sg_index               = ["nonhyeon-public-bastion-ec2"] # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"      # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = true                           # eip 필요 시 에 기입
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"                          # ec2 롤 부여시 기입 현재 SSM Role만 부여
    eni_required           = false                          # private ip 따로 지정해서 사용 안할 시에 False
    network_boundary = "pub"
    purpose          = "public-bastion"
    service          = "nonhyeon"
    region_az        = "apne2a"
    type             = "ec2"
  },

  {
    index                  = "nonhyeon-ec2-private-bastion"
    #ami                    = "ami-09cd9fdbf26acc6b4" # Amazon Linux 2023 AMI 2023.9.20251208.0 x86_64 HVM kernel-6.1
    #ami                    = "ami-002619f9bb1f83273" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04) + CDK 사전 설치 AMI 11/10    
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI
    #ami                    = "ami-0d4a6b537cb9bdca1" # Amazon Linux 2 AMI - Tokyo / (AWS Marketplace AMIs) Amazon Linux 2 AMI 2.0.20251121.0 x86_64 HVM gp2
    ##ami                    = "ami-06000b1a9ad0ea6ca" # Amazon Linux 2 AMI - Tokyo / Installed OpenSwan (AWS Marketplace AMIs) Amazon Linux 2 AMI 2.0.20251121.0 x86_64 HVM gp2        
    ami                    = "ami-0b818a04bc9c2133c" # Seoul Amazon Linux 2023 AMI 2023.9.20251208.0 x86_64 HVM kernel-6.1    
    instance_type          = "t3.medium"
    sub_index              = "nonhyeon-pri-01a"   # subnet 변수 값을 넣어주세요
    sg_index               = ["nonhyeon-private-bastion-ec2"] # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"      # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = false                          # eip 필요 시 에 기입
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"                          # ec2 롤 부여시 기입 현재 SSM Role만 부여
    eni_required           = false                          # private ip 따로 지정해서 사용 안할 시에 False
    network_boundary = "private"
    purpose          = "private-bastion"
    service          = "nonhyeon"
    region_az        = "apne2a"
    type             = "ec2"
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
