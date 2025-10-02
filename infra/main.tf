module "vpc" {
  source     = "./modules/vpc"
}

module "eks" {
  source     = "./modules/eks"
  subnet_ids = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id
}
