provider "google" {
  project = "multi-cloud-k8s-461703"
  region  = "us-east1"  
} 

# ----------------------------------------
# Create a VPC Network
# ----------------------------------------
resource "google_compute_network" "vpc_network" {
  name                    = "multi-cloud-vpc"
  auto_create_subnetworks = false
}

# ----------------------------------------
# Create Subnet
# ----------------------------------------
resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "multi-cloud-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = "us-east1"
  network       = google_compute_network.vpc_network.id
}

# ----------------------------------------
# GKE Cluster (Standard mode, GA provider)
# ----------------------------------------
resource "google_container_cluster" "gke_cluster" {
  name       = "multi-cloud-gke2"
  location   = "us-east1"  
  network    = google_compute_network.vpc_network.name
  subnetwork = google_compute_subnetwork.vpc_subnet.name

  enable_autopilot = false

  release_channel {
    channel = "REGULAR"
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/17"
    services_ipv4_cidr_block = "/22"
  }

deletion_protection = false
  # ✅ Set required initial node count
  initial_node_count = 1
}

# ----------------------------------------
# GKE Custom Node Pool (Optional — for custom workloads)
# ----------------------------------------
resource "google_container_node_pool" "primary_nodes" {
  name     = "primary-node-pool"
  cluster  = google_container_cluster.gke_cluster.name
  location = google_container_cluster.gke_cluster.location

  node_count = 1

  node_config {
    machine_type = "e2-small"
    disk_size_gb   = 30 
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  autoscaling {
    min_node_count = 0
    max_node_count = 2
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}