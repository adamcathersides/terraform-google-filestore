locals {
  project_id     = var.enable_auto_backup ? data.google_client_config.current[0].project : null
  project_number = var.enable_auto_backup ? data.google_project.current[0].number : null
  region         = var.enable_auto_backup ? data.google_client_config.current[0].region : null
}
