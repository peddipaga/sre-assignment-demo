resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false

  depends_on = [google_project_service.enable_apis]
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.10.0.0/16"

  secondary_ip_range {
    range_name    = var.pods_range
    ip_cidr_range = "10.20.0.0/16"
  }

  secondary_ip_range {
    range_name    = var.svc_range
    ip_cidr_range = "10.30.0.0/20"
  }
}

