variable "region" {
  description = "The region in which to deploy the Google Cloud project"
  default     = "europe-west1"
}
variable "project-id" {
  description = "The ID of the Google Cloud project"
}
variable "cloud-run-service-name" {
    description = "The name of the Cloud Run Service"
}