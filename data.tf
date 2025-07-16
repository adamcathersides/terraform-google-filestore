data "google_client_config" "current" {
  # count = var.enable_auto_backup ? 1 : 0
}

data "google_project" "current" {
  # count = var.enable_auto_backup ? 1 : 0

  project_id = data.google_client_config.current.project
}

data "archive_file" "backup_function" {
  count = var.enable_auto_backup ? 1 : 0

  type        = "zip"
  source_dir  = "${path.module}/backup"
  output_path = "${path.module}/filestore-backup.zip"
}
