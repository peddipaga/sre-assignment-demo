output "cluster_name" {
  value = module.gke.name
}

output "cluster_location" {
  value = module.gke.location
}

output "kubernetes_endpoint" {
  value     = module.gke.endpoint
  sensitive = true
}

output "cluster_zone" {
  value = var.zone
}

output "project_id" {
  value = var.project_id
}

# output "argocd_tls_crt" {
#   value     = tls_self_signed_cert.argocd.cert_pem
#   sensitive = true
# }

# output "argocd_tls_key" {
#   value     = tls_private_key.argocd.private_key_pem
#   sensitive = true
# }


