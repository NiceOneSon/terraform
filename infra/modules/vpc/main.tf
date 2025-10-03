module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  azs = ["ap-northeast-2a", "ap-northeast-2c"]
  
  enable_nat_gateway = false
  map_public_ip_on_launch = true

  tags = {
    Environment = "dev"
  }
}
