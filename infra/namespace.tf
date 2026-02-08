resource "kubernetes_namespace" "sre-demo" {
  metadata {
    name = "sre-demo"
  }

  depends_on = [
    module.gke
  ]
}
