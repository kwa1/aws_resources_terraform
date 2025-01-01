locals {
  enabled                = var.enabled
  security_group_enabled = local.enabled && var.create_security_group

  dns_name = format("%s.efs.%s.amazonaws.com", join("", aws_efs_file_system.default.*.id), var.region)

  posix_users = {
    for k, v in var.access_points :
    k => lookup(var.access_points[k], "posix_user", {})
  }

  secondary_gids = {
    for k, v in var.access_points :
    k => lookup(local.posix_users[k], "secondary_gids", null)
  }
}
