resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
    labels = {
      istio-injection = "disabled"
    }
  }
}

resource "helm_release" "istio_base" {
  depends_on = [kubernetes_namespace.istio_system]

  name       = "istio-base"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"
  version    = "1.27.1"
  namespace  = "istio-system"
}

resource "helm_release" "istiod" {
  depends_on = [helm_release.istio_base]

  name       = "istiod"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"
  version    = "1.27.1"
  namespace  = "istio-system"

  set {
    name  = "meshConfig.accessLogFile"
    value = "/dev/stdout"
  }
}

resource "helm_release" "istio_ingress" {
  depends_on = [helm_release.istiod]
  
  name       = "istio-ingressgateway"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"
  version    = "1.27.1"
  namespace  = "istio-system"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "podAnnotations.sidecar\\.istio\\.io/inject"
    value = "\"false\""
  }
}
