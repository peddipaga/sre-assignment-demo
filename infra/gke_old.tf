# resource "google_container_cluster" "gke" {
#   name     = var.cluster_name
#   location = var.zone

#   network    = google_compute_network.vpc.name
#   subnetwork = google_compute_subnetwork.subnet.name

#   remove_default_node_pool = true
#   initial_node_count       = 1

#   ip_allocation_policy {
#     cluster_secondary_range_name  = var.pods_range
#     services_secondary_range_name = var.svc_range
#   }

#   # Keep it simple for demo; you can add Workload Identity etc. as "bonus".
#   logging_service    = "logging.googleapis.com/kubernetes"
#   monitoring_service = "monitoring.googleapis.com/kubernetes"
#   deletion_protection = false
# }

# resource "google_container_node_pool" "primary" {
#   name       = "${var.cluster_name}-np"
#   location   = var.zone
#   cluster    = google_container_cluster.gke.name
#   node_count = var.node_min

#   autoscaling {
#     min_node_count = var.node_min
#     max_node_count = var.node_max
#   }

#   node_config {
#     machine_type = var.node_machine_type
#     oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

#     labels = {
#       env = "demo"
#     }
#   }
# }


# # resource "google_project_service" "cloudresourcemanager" {
# #   service            = "cloudresourcemanager.googleapis.com"
# #   disable_on_destroy = false
# #   project            = var.project_id
# # }

# resource "google_project_service" "enable_apis" {
#   for_each           = toset(var.enabled_apis)
#   service            = each.key
#   disable_on_destroy = false
#   project            = var.project_id

# }