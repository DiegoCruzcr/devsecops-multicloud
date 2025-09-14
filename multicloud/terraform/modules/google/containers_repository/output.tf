output "repository_url" {
  description = "The URL of the container repository"
  value       = google_artifact_registry_repository.my_repo.name
}

output "repository_id" {
  description = "The ID of the container repository"
  value       = google_artifact_registry_repository.my_repo.repository_id
}

output "location" {
  description = "The location of the repository"
  value       = google_artifact_registry_repository.my_repo.location
}
