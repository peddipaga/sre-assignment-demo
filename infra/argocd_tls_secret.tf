resource "kubernetes_secret" "argocd_tls" {
  metadata {
    name      = "argocd-tls"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }

  type = "kubernetes.io/tls"

  data = {
    "tls.crt" = tls_self_signed_cert.argocd.cert_pem
    "tls.key" = tls_private_key.argocd.private_key_pem
  }

  depends_on = [kubernetes_namespace.argocd]
}
