resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  create_namespace = false

  values = [yamlencode({
    server = {
      service = {
        type = "LoadBalancer"
      }
    }
  })]

  depends_on = [
    module.gke,
    kubernetes_namespace.argocd
  ]
}
