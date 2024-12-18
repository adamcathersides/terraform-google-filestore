terraform {
  required_version = ">= 1.7.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.12"
    }

    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.7"
    }
  }
}
