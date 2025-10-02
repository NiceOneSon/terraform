# resource "helm_release" "argocd" {
#   name       = "argocd"
#   repository = "https://argoproj.github.io/argo-helm"
#   chart      = "argo-cd"
#   version    = "7.3.0" # 원하는 버전

#   namespace        = "argocd"
#   create_namespace = true

#   values = [
#     file("argocd-values.yaml")
#   ]
# }
