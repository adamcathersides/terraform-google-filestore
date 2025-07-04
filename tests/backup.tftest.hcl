# mock_provider "google" {}

run "basic" {
  variables {
    location = "europe-west2-a"

    name = "backup"
    tier = "STANDARD"

    file_shares = {
      name        = "warehouse"
      capacity_gb = 1024
    }

    networks = {
      network = "default"
      modes = ["MODE_IPV4"]
    }

    enable_auto_backup                       = true
    auto_backup_function_location            = "europe-west2"
    auto_backup_function_storage_bucket_name = "gcf-v2-sources-461567143261-us-central1"
  }

  assert {
    condition     = length(google_filestore_instance.default) > 0
    error_message = "Google Filestore instance has not been created"
  }

  assert {
    condition     = length(google_cloudfunctions2_function.backup) > 0
    error_message = "Google Cloud Run function for Google Filestore auto backup has not been created"
  }

  assert {
    condition     = length(google_cloud_scheduler_job.backup) > 0
    error_message = "Google Cloud Scheduler job for Google Filestore auto backup has not been created"
  }

  # TODO: Assert Cloud Scheduler force run result
}
