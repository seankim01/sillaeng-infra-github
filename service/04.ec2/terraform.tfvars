ec2_create = [

  # ============================================
  # Bastion Host (t3.micro, Public Subnet, Amazon Linux)
  # ============================================
  {
    index                  = "service-ec2-bastion"
    ami                    = "ami-07b70db997adb22fb" # Amazon Linux 2023 AMI x86_64 HVM
    instance_type          = "t3.small"
    sub_index              = "service-pub-01a"
    sg_index               = ["service-pub-bastion-ec2"]
    key_name               = "mzc-dsa04-shared"
    volume_size            = 30
    volume_type            = "gp3"
    eip_required           = true
    user_data              = "userdata/example_userdata.sh"
    instance_profile_index = "ssm"
    eni_required           = false
    network_boundary       = "pub"
    purpose                = "bastion"
    service                = "service"
    region_az              = "apne2a"
    type                   = "ec2"
  },

  # ============================================
  # App 서버 (m6i.xlarge, 4vCPU/16GB, Ubuntu)
  # ============================================
  # {
  #   index                  = "service-ec2-app-01a"
  #   ami                    = "ami-024ea438fac90c80d" # Ubuntu 22.04 LTS x86_64
  #   instance_type          = "m6i.xlarge"
  #   sub_index              = "service-pri-app-01a"
  #   sg_index               = ["service-private-app-ec2"]
  #   key_name               = "mzc-dsa04-shared"
  #   volume_size            = 200
  #   volume_type            = "gp3"
  #   eip_required           = false
  #   user_data              = "userdata/example_userdata.sh"
  #   instance_profile_index = "ssm"
  #   eni_required           = false
  #   network_boundary       = "private"
  #   purpose                = "app"
  #   service                = "service"
  #   region_az              = "apne2a"
  #   type                   = "ec2"
  # },

  # ============================================
  # GPU 운영 추론 서버 (g6e.xlarge, 4vCPU/32GB, Ubuntu)
  # ============================================
  # {
  #   index                  = "service-ec2-gpu-infer-01a"
  #   ami                    = "ami-06adeb45a79fb3728" # Deep Learning Ubuntu AMI
  #   instance_type          = "g6e.xlarge"
  #   sub_index              = "service-pri-gpu-infer-01a"
  #   sg_index               = ["service-private-gpu-infer-ec2"]
  #   key_name               = "mzc-dsa04-shared"
  #   volume_size            = 200
  #   volume_type            = "gp3"
  #   eip_required           = false
  #   user_data              = "userdata/example_userdata.sh"
  #   instance_profile_index = "ssm"
  #   eni_required           = false
  #   spot_enabled           = true
  #   spot_instance_type     = "persistent"
  #   spot_interruption_behavior = "stop"
  #   network_boundary       = "private"
  #   purpose                = "gpu-infer"
  #   service                = "service"
  #   region_az              = "apne2a"
  #   type                   = "ec2"
  # },

  # ============================================
  # GPU 학습 개발 서버 1 (g6e.xlarge, 4vCPU/32GB, Ubuntu)
  # ============================================
  # {
  #   index                  = "service-ec2-gpu-train-01a"
  #   ami                    = "ami-06adeb45a79fb3728" # Deep Learning Ubuntu AMI
  #   instance_type          = "g6e.xlarge"
  #   sub_index              = "service-pri-gpu-train-01a"
  #   sg_index               = ["service-private-gpu-train-ec2"]
  #   key_name               = "mzc-dsa04-shared"
  #   volume_size            = 200
  #   volume_type            = "gp3"
  #   eip_required           = false
  #   user_data              = "userdata/example_userdata.sh"
  #   instance_profile_index = "ssm"
  #   eni_required           = false
  #   spot_enabled           = true
  #   spot_instance_type     = "persistent"
  #   spot_interruption_behavior = "stop"
  #   network_boundary       = "private"
  #   purpose                = "gpu-train-01"
  #   service                = "service"
  #   region_az              = "apne2a"
  #   type                   = "ec2"
  # },

  # ============================================
  # GPU 학습 개발 서버 2 (g6e.xlarge, 4vCPU/32GB, Ubuntu)
  # ============================================
  # {
  #   index                  = "service-ec2-gpu-train-02c"
  #   ami                    = "ami-06adeb45a79fb3728" # Deep Learning Ubuntu AMI
  #   instance_type          = "g6e.xlarge"
  #   sub_index              = "service-pri-gpu-train-02c"
  #   sg_index               = ["service-private-gpu-train-ec2"]
  #   key_name               = "mzc-dsa04-shared"
  #   volume_size            = 200
  #   volume_type            = "gp3"
  #   eip_required           = false
  #   user_data              = "userdata/example_userdata.sh"
  #   instance_profile_index = "ssm"
  #   eni_required           = false
  #   spot_enabled           = true
  #   spot_instance_type     = "persistent"
  #   spot_interruption_behavior = "stop"
  #   network_boundary       = "private"
  #   purpose                = "gpu-train-02"
  #   service                = "service"
  #   region_az              = "apne2c"
  #   type                   = "ec2"
  # },

  # ============================================
  # 개발 서버 (t3.large, 2vCPU/8GB, Ubuntu)
  # ============================================
  {
    index                  = "service-ec2-dev-01a"
    ami                    = "ami-012a353bb3afb92ee" # Ubuntu 22.04 LTS x86_64 (2026-07-31)
    instance_type          = "t3.medium"
    sub_index              = "service-pri-dev-01a"
    sg_index               = ["service-private-dev-ec2"]
    key_name               = "mzc-dsa04-shared"
    volume_size            = 100
    volume_type            = "gp3"
    eip_required           = false
    user_data              = "userdata/example_userdata.sh"
    instance_profile_index = "ssm"
    eni_required           = false
    network_boundary       = "private"
    purpose                = "dev"
    service                = "service"
    region_az              = "apne2a"
    type                   = "ec2"
  },

]

iam_create = [
  {
    index   = "ssm"
    purpose = "service"
  }
]

iam_policy_create = [

]

iam_policy_attach = [
  {
    index      = "ssm-attach"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
    iam_index  = "ssm"
  }
]
