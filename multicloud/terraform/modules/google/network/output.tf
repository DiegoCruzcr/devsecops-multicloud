output "services_secondary_range_name" {
  description = "Nome do intervalo secundário de serviços"
  value       = google_compute_subnetwork.subnetwork.secondary_ip_range[0].range_name
  
}

output "cluster_secondary_range_name" {
  description = "Nome do intervalo secundário de clusters"
  value       = google_compute_subnetwork.subnetwork.secondary_ip_range[1].range_name

}

output "network_name" {
  description = "Nome da rede VPC"
  value       = google_compute_network.network.name
}

output "subnetwork_name" {
  description = "Nome da sub-rede"
  value       = google_compute_subnetwork.subnetwork.name
}

output "network_self_link" {
  description = "Self link da rede VPC"
  value       = google_compute_network.network.self_link
}

output "subnetwork_self_link" {
  description = "Self link da sub-rede"
  value       = google_compute_subnetwork.subnetwork.self_link
}