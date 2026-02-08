variable "project_id" {
  type    = string
  default = "sre-assignment-gke-hpa"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "cluster_name" {
  type    = string
  default = "sre-assignment-gke"
}

variable "vpc_name" {
  type    = string
  default = "sre-assignment-vpc"
}

variable "subnet_name" {
  type    = string
  default = "sre-assignment-subnet"
}

variable "pods_range" {
  type    = string
  default = "gke-pods"
}

variable "svc_range" {
  type    = string
  default = "gke-services"
}

variable "node_machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "node_min" {
  type    = number
  default = 2
}

variable "node_max" {
  type    = number
  default = 5
}

variable "enabled_apis" {
  type = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "artifactregistry.googleapis.com",
    "iam.googleapis.com"
    ]
}