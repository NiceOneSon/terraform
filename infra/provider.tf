terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }

  # backend (옵션: S3 + DynamoDB로 state 관리 시)
  backend "s3" {
    bucket         = "jinyoung-project-quantitative-terraform"
    key            = "quantitative/eks/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-northeast-2"
}


# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.this.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.this.token
# }

# provider "helm" {
#   kubernetes = {
#     config_path = "~/.kube/config"
#   }
# }
