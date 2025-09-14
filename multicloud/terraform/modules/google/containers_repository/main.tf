resource "google_artifact_registry_repository" "my_repo" {
  location      = var.location
  repository_id = var.repository_name
  description   = var.description
  format        = "DOCKER"

  docker_config {
    immutable_tags = false
  }

  labels = var.labels
}

# Enable required APIs
resource "google_project_service" "artifact_registry" {
  service = "artifactregistry.googleapis.com"
  
  disable_on_destroy         = false
}

resource "google_project_service" "container_api" {
  service = "container.googleapis.com"
  
  disable_on_destroy         = false
}
