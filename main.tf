resource "google_filestore_instance" "default" {
  # Infer from provider configuration
  # project = var.project
  # location = var.location

  name        = var.name
  description = var.description
  tier        = var.tier
  protocol    = var.protocol

  file_shares {
    name          = var.file_shares.name
    capacity_gb   = var.file_shares.capacity_gb
    source_backup = var.file_shares.source_backup

    dynamic "nfs_export_options" {
      for_each = var.file_shares.nfs_export_options

      content {
        ip_ranges   = nfs_export_options.value.ip_ranges
        access_mode = nfs_export_options.value.access_mode
        squash_mode = nfs_export_options.value.squash_mode
        anon_uid    = nfs_export_options.value.anon_uid
        anon_gid    = nfs_export_options.value.anon_gid
      }
    }
  }

  networks {
    network           = var.networks.network
    modes             = var.networks.modes
    connect_mode      = var.networks.connect_mode
    reserved_ip_range = var.networks.reserved_ip_range
  }

  kms_key_name = var.kms_key_name

  deletion_protection_enabled = var.deletion_protection_enabled
  deletion_protection_reason  = var.deletion_protection_reason

  dynamic "performance_config" {
    for_each = var.performance_config != null ? [var.performance_config] : []

    content {
      dynamic "iops_per_tb" {
        for_each = performance_config.value.iops_per_tb != null ? [performance_config.value.iops_per_tb] : []

        content {
          max_iops_per_tb = performance_config.value.iops_per_tb.max_iops_per_tb
        }
      }

      dynamic "fixed_iops" {
        for_each = performance_config.value.fixed_iops != null ? [performance_config.value.fixed_iops] : []

        content {
          max_iops = performance_config.value.fixed_iops.max_iops
        }
      }
    }
  }

  labels = var.labels
}
