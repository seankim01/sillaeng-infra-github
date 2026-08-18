# "신라엔지니어링 AWS AI 학습기반 인프라" Terraform 

AI 학습 위한 Terraform 코드 입니다.


## Getting started

Terraform 모듈은 Modules 폴더 내에 AWS Service 별로 정리하였습니다.
Service에서 해당 Module 불러와 설정 값 입력 후에 실행하시면 됩니다.


## Directory 

```
├── README.md
├── modules
│   ├── EC2
│   │   ├── README.md
│   │   ├── ec2.tf
│   │   ├── iam-role.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   ├── Loadbalancer
│   │   ├── README.md
│   │   ├── lb.tf
│   │   └── variable.tf
│   └── Network
│       ├── tgw
│       │   ├── README.md
│       │   ├── output.tf
│       │   ├── tgw.tf
│       │   ├── tgw_route_table.tf
│       │   ├── variable.tf
│       │   └── vpn.tf
│       └── vpc
│           ├── README.md
│           ├── gateway.tf
│           ├── output.tf
│           ├── route_table.tf
│           ├── security_group.tf
│           ├── subnet.tf
│           ├── variable.tf
│           ├── vpc.tf
│           ├── vpc_endpoint.tf
│           └── vpc_flowlog.tf
└── service
    ├── ec2
    │   ├── README.md
    │   ├── data.tf
    │   ├── main.tf
    │   ├── output.tf
    │   ├── provider.tf
    │   ├── terraform.tfvars
    │   ├── userdata
    │   │   └── example_userdata.sh
    │   └── variable.tf
    ├── loadbalancer
    │   ├── README.md
    │   ├── data.tf
    │   ├── main.tf
    │   ├── output.tf
    │   ├── provider.tf
    │   ├── terraform.tfvars
    │   └── variable.tf
    └── network
        ├── README.md
        ├── main.tf
        ├── output.tf
        ├── provider.tf
        ├── route_rules.csv
        ├── security_group_rules.csv
        ├── terraform.tfvars
        └── variable.tf
```

# How To Use
### Step 0. 사전 준비 사항
1. AWS Credential Setting
- IAM 생성 및 생성한 계정의 액세스 키 발급
- aws configure 명령어를 통해 awscli login
 - awscli가 사전에 설치되어 있어야 합니다.
 - 참고 문서 - [CLI 설치](https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/getting-started-install.html)
2. Terraform Install
- 참고 문서 - [Terraoform 설치](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
3. Required commands
- terraform init : terraform 초기화 명령어로 사용하는 모듈을 다운로드
- terraform plan : 작성한 코드를 통해 어떤 리소스가 변경될지 예상 결과를 출력
- terraform apply : 코드를 통해 리소스를 프로비저닝
- terraform destroy : terraform을 통해 생성한 리소스를 삭제
4. Option commands
- terraform state list # terraform으로 관리하고 있는 리소스 확인
- terraform state rm 'resoruce_name' # terraform 관리하는 리소스 목록에서 해당 리소스를 삭제, 실제 리소스 삭제가 아닌 더이상 terraform으로 관리하지 않을 경우 사용
- terraform import 'resource_name' 'resource_id' # terraform state 파일에 기록되어 있지 않은 리소스를 terraform으로 관리할 경우 사용
5. 변수 사용 방법
- variables.tf에 변수 선언 후 terraform.tfvars에 해당 변수의 값 선언
6. Naming Rule 
- 각 요소의 구분 및 요소 내 세부정보 사이는 '-' (Dash)로 구분
- {var.company}-{var.env}-{var.service}-{index}
- ex) hsfms-dr-mng-vpc


---

### Step 1. Terraform Provider 설정  

각 서비스별 모듈 내에 provider.tf를 설정해야합니다.  
terraform 블럭은 aws version을 선언하고, Backend를 설정합니다.  

Backend를 S3로 설정
- Locking : Terraform 코드를 여러 명의 인프라 담당자가 작성하며, 인프라를 변경하는 것은 민감한 작업임. DynamoDB와 원격 저장소를 사용함으로써 동시에 같은 state를 접근하는 것을 막아 의도치 않은 변경을 방지
- Backup : 로컬 스토리지에 state file을 저장하면 유실 가능성이 높음으로 S3와 같은 원격 저장소에 저장
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    profile        = "default"
    bucket         = "dco-dr-tf"
    key            = "dr/network/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "dco-dr-lock"
    acl            = "bucket-owner-full-control"
  }
}

provider "aws" {
  region  = "ap-northeast-2"
  profile = "default"

  # default_tags {
  #   tags = {
  #     User = "jigreg" # Replace with your name
  #   }
  # }
}

```
각 Service 별로 변경되는 부분은 key (각 state별 저장될 s3 path를 적기)  
provider 설정이 완료 되었으면 
```
terraform init
```
---
### Step 2. Resource 선언하기

Module을 보면서 필요한 항목들을 terraform.tfvars에 규칙에 맞춰서 선언합니다.

필요한 input 및 output들은 각 모듈의 README.md를 참조합니다.

생성할 리소스들을 테라폼 코드로 선언했다면 검증합니다.
```
terraform plan
```
선언하려던 리소스들인지 확인합니다.
---
### Step 3. 인프라 프로비저닝하기
plan을 통해 선언한 인프라가 맞는지 확인 후에는 인프라를 생성합니다.
```
terraform apply
```
apply를 통해 인프라를 생성하고 AWS Console에서 제대로 생성되었는지 확인합니다.

---

### Step 4. 인프라 수정하기

초기 인프라를 선언 이 후에 수정할 리소스가 있다면 Service 폴더 내에서 수정 후에 다시 한번 apply 하면 수정됩니다.

단, 아예 삭제된 후에 재생성되는 경우도 있고, 안에 설정 값들이 수정되는 경우도 있긴 때문에 항상 plan으로 확인 후에 진행해야합니다.

---

### Step 5. 인프라 제거하기

필요 없는 인프라는 destroy를 통해 제거 할 수 있습니다.
```
terraform destroy
```
해당 모듈 내에서 일부만 제거를 하고 싶을 때는 tfvars에서 제거한 후에 apply
