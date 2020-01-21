variable "machine_type" {
  description = "The type of virtual machine used to deploy apache"
  default     = "f1-micro"
}
variable "project_id" {
  description = "The ID of the Google Cloud project"
}
variable "region" {
  description = "The region in which to deploy the Google Cloud project"
  default     = "europe-west2"
}
variable "region_zone" {
  description = "The region zone in which to deploy the Google Cloud project"
  default     = "europe-west2-a"
}
variable "stack_prefix" {
  description = "The prefix for the stacks to be deployed, e.g. application name or your name followed by a hyphen"
}
variable "svca_pub_inb_out" {
  description = "Service Account for Non privileged inbound and outbound access"
}