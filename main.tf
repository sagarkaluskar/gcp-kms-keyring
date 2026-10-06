terraform {
  required_version = ">= 1.3.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.gcp_region
}

resource "google_kms_key_ring" "this" {
  name     = "${var.name_prefix}-ring"
  location = var.gcp_region
}

resource "google_kms_crypto_key" "this" {
  name            = "${var.name_prefix}-key"
  key_ring        = google_kms_key_ring.this.id
  rotation_period = "7776000s"
}
