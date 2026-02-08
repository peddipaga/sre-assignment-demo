resource "google_service_account" "gke_nodes" {
  account_id   = "gke-nodes-sa"
  display_name = "GKE Node Pool Service Account"
}


module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 35.0"

  project_id = var.project_id
  name       = var.cluster_name

  regional = false
  zones    = [var.zone]

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  ip_range_pods     = var.pods_range
  ip_range_services = var.svc_range

  remove_default_node_pool  = true
  deletion_protection       = false
  default_max_pods_per_node = 32

  create_service_account = false
  service_account        = google_service_account.gke_nodes.email

  # Below would grand access to GCR (which is legacy) and Artifact Registry
  # grant_registry_access = true

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  # IMPORTANT: keep node_pools values scalar (no lists/maps here)
  node_pools = [
    {
      name         = "${var.cluster_name}-np"
      machine_type = var.node_machine_type

      min_count     = var.node_min
      max_count     = var.node_max
      initial_count = var.node_min
    }
  ]

  # Put oauth scopes here (module expects this separately)
  node_pools_oauth_scopes = {
    all = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  # Put labels here (module expects this separately)
  node_pools_labels = {
    all = {}
    "${var.cluster_name}-np" = {
      env = "demo"
    }
  }

  depends_on = [google_project_service.enable_apis]
}