variable "project" {
  description = "The GCP project ID to deploy resources into."
  type        = string
  default     = "cc-assignment-1-437714"
}

variable "region" {
  description = "The GCP region to deploy resources into."
  type        = string
  default     = "us-central1"
}
variable "zone" {
  description = "The GCP zone within the specified region to deploy resources into."
  type        = string
  default     = "us-central1-a"
}
variable "GOOGLE_CREDENTIALS" {
  description = "The JSON key file content for the GCP service account."
  type        = string
}
variable "vm" {
  type = map(object({
    name         = string
    machine_type = string
    boot_disk = object({
      initialize_params = object({
        image = string
        size  = number
        type  = string
      })
    })
    network_interface = object({
      network = string
    })
    scheduling = object({
      preemptible        = bool
      automatic_restart  = bool
      provisioning_model = string
    })
    tags                      = list(string)
    allow_stopping_for_update = bool
    desired_status            = string
  }))
}
locals {
}