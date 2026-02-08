resource "kubernetes_namespace" "sre-demo" {
  metadata {
    name = "sre-demo"
  }

  depends_on = [
    module.gke
  ]
}

resource "kubernetes_namespace" "argocd" {
  metadata { 
    name = "argocd" 
    }
  depends_on = [module.gke]
}

