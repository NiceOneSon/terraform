resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  depends_on = [ kubernetes_namespace.argocd ]
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = "argocd"

  values = [
    file("yaml/argocd-values.yaml")
  ]
}

resource "kubernetes_secret" "argocd_github" {
  depends_on = [ kubernetes_namespace.argocd ]
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
  depends_on = [ kubernetes_namespace.argocd ]
  metadata {
    name      = "argocd-ssh-key"
    namespace = "argocd"
  }

  data = {
    sshPrivateKey = base64encode(file("./argocd_id_ed25519"))
  }

  type = "Opaque"
}

resource "kubernetes_manifest" "argocd_gateway" {
  depends_on = [ kubernetes_namespace.argocd ]
  manifest = yamldecode(file("yaml/argocd-gateway.yaml"))
}

resource "kubernetes_manifest" "argocd_virtualservice" {
  depends_on = [ kubernetes_namespace.argocd ]
  manifest = yamldecode(file("yaml/argocd-virtualservice.yaml"))
}