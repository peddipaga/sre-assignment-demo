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



