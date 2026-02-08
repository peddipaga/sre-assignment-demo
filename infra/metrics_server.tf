# resource "helm_release" "metrics_server" {
#   name       = "metrics-server"
#   repository = "https://kubernetes-sigs.github.io/metrics-server/"
#   chart      = "metrics-server"
#   namespace  = "kube-system"

#   set = [
#     {
#       name  = "app.kubernetes.io/managed-by"
#       value = "Helm"
#     },
#     {
#       name  = "meta.helm.sh/release-name"
#       value = "metrics-server"
#     },
#     {
#       name  = "meta.helm.sh/release-namespace"
#       value = "kube-system"
#     }
#   ]

#   create_namespace = true

#   values = [yamlencode({
#     args = [
#       "--kubelet-preferred-address-types=InternalIP",
#       "--kubelet-insecure-tls"
#     ]
#   })]

#   depends_on = [
#     module.gke
#   ]
# }


