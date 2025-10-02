module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs            = ["ap-northeast-2a"]
  public_subnets = ["10.0.1.0/24"]

  # NAT 사용 안 함
  enable_nat_gateway = false

  tags = {
    Environment = "dev"
  }
}
