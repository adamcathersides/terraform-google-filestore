mock_provider "google" {}

run "basic" {
  variables {
    name = "basic"
    tier = "STANDARD"

    file_shares = {
      name        = "warehouse"
      capacity_gb = 1024
    }

    networks = {
      network = "default"
      modes = ["MODE_IPV4"]
    }
  }

  assert {
    condition     = length(google_filestore_instance.default) > 0
    error_message = "Google Filestore instance has not been created"
  }
}
