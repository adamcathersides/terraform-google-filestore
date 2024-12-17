mock_provider "google" {}

variables {
  name = "basic"
  tier = "STANDARD"

  file_shares = {
    name        = "warehouse"
    capacity_gb = 1024
  }

  networks = {
    network = "default"
    modes   = ["MODE_IPV4"]
  }
}

run "expect_failure_on_unsupported_tier" {
  command = plan

  variables {
    tier = "UNSUPPORTED"
  }

  expect_failures = [
    var.tier,
  ]
}
