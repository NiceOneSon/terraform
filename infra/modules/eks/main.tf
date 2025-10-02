module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = "eks-dev"
  cluster_version = "1.31"

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  cluster_endpoint_public_access = true
  enable_irsa                    = true

  cluster_enabled_log_types = []
  create_cloudwatch_log_group     = false
  cloudwatch_log_group_retention_in_days = 0
}
