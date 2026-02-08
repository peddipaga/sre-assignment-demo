resource "kubernetes_ingress_v1" "argocd" {
  metadata {
    name      = "argocd-ingress"
    namespace = "argocd"

    annotations = {
      "nginx.ingress.kubernetes.io/backend-protocol" = "HTTPS"
      "nginx.ingress.kubernetes.io/proxy-ssl-verify" = "off"
    }
  }

  spec {
    ingress_class_name = "nginx"

    tls {
      hosts       = ["argocd.hippocraticdemo.com"]
      secret_name = "argocd-tls"
    }

    rule {
      host = "argocd.hippocraticdemo.com"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "argocd-server"
              port { number = 443 }
            }
          }
        }
      }
    }
  }

  depends_on = [
  helm_release.ingress_nginx,
  helm_release.argocd,
  kubernetes_secret.argocd_tls
  ]

}
