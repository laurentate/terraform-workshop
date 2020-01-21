resource "google_cloud_run_service" "cloud-run-service" {
  name     = var.cloud-run-service-name
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
output "url" {
  value = "${google_cloud_run_service.cloud-run-service.status[0].url}"
}