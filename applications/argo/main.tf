resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = "argocd"
  create_namespace = true

  values = [
    file("yaml/argocd-values.yaml")
  ]
}

resource "kubernetes_secret" "argocd_github" {
  metadata {
    name      = "argocd-github-cred"
    namespace = "argocd"
  }

  data = {
    username = local.username
    password = local.password
  }

  type = "Opaque"
}

resource "kubernetes_secret" "argocd_ssh_key" {
  metadata {
    name      = "argocd-ssh-key"
    namespace = "argocd"
  }

  data = {
    sshPrivateKey = base64encode(file("./argocd_id_ed25519"))
  }

  type = "Opaque"
}
