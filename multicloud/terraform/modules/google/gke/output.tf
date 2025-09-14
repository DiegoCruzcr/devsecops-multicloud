output "cluster_name" {
  description = "Nome do cluster GKE"
  value       = google_container_cluster.my-cluster.name
}

output "cluster_endpoint" {
  description = "Endpoint do cluster GKE"
  value       = google_container_cluster.my-cluster.endpoint
}

output "cluster_location" {
  description = "Localização do cluster GKE"
  value       = google_container_cluster.my-cluster.location
}

output "cluster_ca_certificate" {
  description = "Certificado CA do cluster"
  value       = google_container_cluster.my-cluster.master_auth[0].cluster_ca_certificate
  sensitive   = true
}