resource "google_compute_network" "network" {
  name = "multicloud-network"

  auto_create_subnetworks  = false
  enable_ula_internal_ipv6 = true
}

resource "google_compute_subnetwork" "subnetwork" {
  name = "multicloud-subnetwork"

  ip_cidr_range = var.ip_cidr_range
  region        = var.region

  stack_type       = "IPV4_IPV6"
  ipv6_access_type = "EXTERNAL" # Change to "EXTERNAL" if creating an external loadbalancer

  network = google_compute_network.network.id
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = var.secondary_ip_range_services
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = var.secondary_ip_range_pods
  }
}