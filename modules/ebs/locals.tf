locals {
  volume_size          = var.volume_size
  volume_type          = var.volume_type
  iops                 = var.iops != null ? var.iops : (var.volume_type == "gp3" ? 3000 : null)
  throughput           = var.throughput != null ? var.throughput : (var.volume_type == "gp3" ? 125 : null)
  multi_attach_enabled = var.multi_attach_enabled
  device_name          = var.device_name
  force_detach         = var.force_detach
}
