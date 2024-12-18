locals {
  project_id     = data.google_client_config.current[0].project
  project_number = data.google_project.current[0].number
  region         = data.google_client_config.current[0].region
}
