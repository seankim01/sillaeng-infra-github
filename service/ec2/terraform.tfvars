ec2_create = [

  {
    index                  = "mng-ec2-public-bastion"
    ami                    = "ami-07b70db997adb22fb" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04)
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI
    instance_type          = "t3.small"
    sub_index              = "mng-pub-01a"   # subnet 변수 값을 넣어주세요
    sg_index               = ["mng-public-bastion-ec2"] # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"      # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = true                           # eip 필요 시 에 기입
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"                          # ec2 롤 부여시 기입 현재 SSM Role만 부여
    eni_required           = false                          # private ip 따로 지정해서 사용 안할 시에 False
    network_boundary = "pub"
    purpose          = "public-bastion"
    service          = "mng"
    region_az        = "apne2a"
    type             = "ec2"
  },

  {
    index                  = "mng-ec2-private-bastion"
    #ami                    = "ami-07b70db997adb22fb" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04)
    ami                    = "ami-002619f9bb1f83273" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04) + CDK 사전 설치 AMI 11/10    
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI
    instance_type          = "t3.medium"
    sub_index              = "mng-pri-01a"   # subnet 변수 값을 넣어주세요
    sg_index               = ["mng-private-bastion-ec2"] # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"      # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = false                          # eip 필요 시 에 기입
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"                          # ec2 롤 부여시 기입 현재 SSM Role만 부여
    eni_required           = false                          # private ip 따로 지정해서 사용 안할 시에 False
    network_boundary = "private"
    purpose          = "private-bastion"
    service          = "mng"
    region_az        = "apne2a"
    type             = "ec2"
  },


  {
    index                  = "service-ec2-public-bastion"
    ami                    = "ami-07b70db997adb22fb" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04)
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI
    instance_type          = "t3.small"
    sub_index              = "service-pub-01a"   # subnet 변수 값을 넣어주세요
    sg_index               = ["service-public-bastion-ec2"] # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"      # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = true                           # eip 필요 시 에 기입
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"                          # ec2 롤 부여시 기입 현재 SSM Role만 부여
    eni_required           = false                          # private ip 따로 지정해서 사용 안할 시에 False
    network_boundary = "pub"
    purpose          = "public-bastion"
    service          = "service"
    region_az        = "apne2a"
    type             = "ec2"
  },

  {
    index                  = "service-ec2-private-bastion"
    #ami                    = "ami-07b70db997adb22fb" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04)
    ami                    = "ami-002619f9bb1f83273" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04) + CDK 사전 설치 AMI 11/10    
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI
    instance_type          = "t3.medium"
    sub_index              = "service-pri-01a"   # subnet 변수 값을 넣어주세요
    sg_index               = ["service-private-bastion-ec2"] # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"      # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = false                          # eip 필요 시 에 기입
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"                          # ec2 롤 부여시 기입 현재 SSM Role만 부여
    eni_required           = false                          # private ip 따로 지정해서 사용 안할 시에 False
    network_boundary = "private"
    purpose          = "private-bastion"
    service          = "service"
    region_az        = "apne2a"
    type             = "ec2"
  },



  {
    index                  = "dev-ec2-public-bastion"
    ami                    = "ami-07b70db997adb22fb" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04)
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI
    instance_type          = "t3.small"
    sub_index              = "dev-pub-01a"   # subnet 변수 값을 넣어주세요
    sg_index               = ["dev-public-bastion-ec2"] # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"      # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = true                           # eip 필요 시 에 기입
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"                          # ec2 롤 부여시 기입 현재 SSM Role만 부여
    eni_required           = false                          # private ip 따로 지정해서 사용 안할 시에 False
    network_boundary = "pub"
    purpose          = "public-bastion"
    service          = "dev"
    region_az        = "apne2a"
    type             = "ec2"
  },

  {
    index                  = "dev-ec2-private-bastion"
    ami                    = "ami-07b70db997adb22fb" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04)
    #ami                    = "ami-002619f9bb1f83273" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04) + CDK 사전 설치 AMI 11/10    
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI
    instance_type          = "t3.medium"
    sub_index              = "dev-pri-01a"   # subnet 변수 값을 넣어주세요
    sg_index               = ["dev-private-bastion-ec2"] # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"      # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = false                          # eip 필요 시 에 기입
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"                          # ec2 롤 부여시 기입 현재 SSM Role만 부여
    eni_required           = false                          # private ip 따로 지정해서 사용 안할 시에 False
    network_boundary = "private"
    purpose          = "private-bastion"
    service          = "dev"
    region_az        = "apne2a"
    type             = "ec2"
  },




  {
    index                  = "ec2-stadium0001"
    ami                    = "ami-002619f9bb1f83273" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04) + CDK 사전 설치 AMI 11/10 
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI
    #ami                    = "ami-04b7e5dc663654c8b" # RHEL 8.1 AMI, Official    
    instance_type          = "t3.medium"
    sub_index              = "service-pri-01a"   # subnet 변수 값을 넣어주세요
    sg_index               = ["stadium-ec2"] # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"      # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = false
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"
    eni_required           = true             # private ip 따로 지정해서 사용 시에 true
    private_ips            = "172.25.1.21" # 사용할 private ip 기입

    network_boundary = "private"
    purpose          = "stadium0001"
    service          = "service"
    region_az        = "apne2a"
    type             = "ec2"
  },
  {
    index                  = "ec2-stadium0002"
    ami                    = "ami-002619f9bb1f83273" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04) + CDK 사전 설치 AMI 11/10 
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI
    #ami                    = "ami-04b7e5dc663654c8b" # RHEL 8.1 AMI, Official        
    instance_type          = "t3.medium"
    sub_index              = "service-pri-02c"   # subnet 변수 값을 넣어주세요
    sg_index               = ["stadium-ec2"] # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"      # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = false
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"
    eni_required           = true             # private ip 따로 지정해서 사용 시에 true
    private_ips            = "172.25.2.22" # 사용할 private ip 기입

    network_boundary = "private"
    purpose          = "stadium0002"
    service          = "service"
    region_az        = "apne2c"
    type             = "ec2"
  },



  {
    index                  = "ec2-runner0001"
    ami                    = "ami-002619f9bb1f83273" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04) + CDK 사전 설치 AMI 11/10 
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI
    #ami                    = "ami-04b7e5dc663654c8b" # RHEL 8.1 AMI, Official        
    instance_type          = "t3.medium"
    sub_index              = "service-pri-01a" # subnet 변수 값을 넣어주세요
    sg_index               = ["runner-ec2"]           # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"                # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = false
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"
    eni_required           = true             # private ip 따로 지정해서 사용 시에 true
    private_ips            = "172.25.1.121" # 사용할 private ip 기입

    network_boundary = "private"
    purpose          = "runner0001"
    service          = "service"
    region_az        = "apne2a"
    type             = "ec2"
  },

  {
    index                  = "ec2-runner0002"
    ami                    = "ami-002619f9bb1f83273" # Amazon Linux 2023 AMI 2023.9.20251105.0 x86_64 HVM kernel-6.1 (2025-11-04) + CDK 사전 설치 AMI 11/10 
    #ami                    = "ami-089cd96a3fed9a2e8" # Amazon Linux 2 AMI    
    #ami                    = "ami-04b7e5dc663654c8b" # RHEL 8.1 AMI, Official        
    instance_type          = "t3.medium"
    sub_index              = "service-pri-02c" # subnet 변수 값을 넣어주세요
    sg_index               = ["runner-ec2"]           # 보안그룹 변수 값을 넣어주세요
    key_name               = "seank-dsa12"                # 본인 key로 바꾸세요.
    volume_size            = 20
    volume_type            = "gp3"
    eip_required           = false
    user_data              = "userdata/example_userdata.sh" # user data 경로 기입
    instance_profile_index = "ssm"
    eni_required           = true             # private ip 따로 지정해서 사용 시에 true
    private_ips            = "172.25.2.122" # 사용할 private ip 기입

    network_boundary = "private"
    purpose          = "runner0002"
    service          = "service"
    region_az        = "apne2c"
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
