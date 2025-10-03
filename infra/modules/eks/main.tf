module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0" 

  name    = "eks-dev"
  kubernetes_version = "1.31"

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  enabled_log_types = []

  endpoint_public_access = true
  enable_irsa                    = true

  create_cloudwatch_log_group     = false
  cloudwatch_log_group_retention_in_days = 0

  enable_cluster_creator_admin_permissions= true

  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }

  access_entries = {
    admin = {
      principal_arn = local.admin_role_arn
      policy_associations = {
        admin = {
          policy_arn  = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = { type = "cluster" }
        }
      }
    }
  }
  eks_managed_node_groups = {
    default = {
      name = "default"
      instance_types = ["t3.medium"]
      desired_size   = 1
      min_size       = 1
      max_size       = 1
    }
  }


}
