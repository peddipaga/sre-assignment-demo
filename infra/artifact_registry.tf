resource "google_artifact_registry_repository" "sre-takehome-demo" {
  project       = var.project_id
  location      = var.region          # us-central1
  repository_id = "sre-takehome-demo"
  description   = "Docker images for SRE assignment"
  format        = "DOCKER"

  depends_on = [google_project_service.enable_apis]
}