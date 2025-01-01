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

resource "aws_efs_file_system" "default" {
  count                           = local.enabled ? 1 : 0
  encrypted                       = true
  kms_key_id                      = var.kms_key_id
  availability_zone_name          = var.availability_zone_name
  performance_mode                = var.performance_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
  throughput_mode                 = var.throughput_mode
  tags                            = var.tags

  dynamic "lifecycle_policy" {
    for_each = length(var.transition_to_ia) > 0 ? [1] : []
    content {
      transition_to_ia = try(var.transition_to_ia[0], null)
    }
  }

  dynamic "lifecycle_policy" {
    for_each = length(var.transition_to_primary_storage_class) > 0 ? [1] : []
    content {
      transition_to_primary_storage_class = try(var.transition_to_primary_storage_class[0], null)
    }
  }
}

resource "aws_efs_mount_target" "default" {
  count          = local.enabled && length(var.subnets) > 0 ? length(var.subnets) : 0
  file_system_id = aws_efs_file_system.default[0].id
  subnet_id      = var.subnets[count.index]
  security_groups = compact(
    concat(
      [module.security_group.id],
      var.additional_security_group_ids
    )
  )
}

resource "aws_efs_access_point" "default" {
  for_each = local.enabled ? var.access_points : {}

  file_system_id = aws_efs_file_system.default[0].id

  dynamic "posix_user" {
    for_each = local.posix_users[each.key] != null ? ["true"] : []

    content {
      gid            = local.posix_users[each.key]["gid"]
      uid            = local.posix_users[each.key]["uid"]
      secondary_gids = local.secondary_gids[each.key] != null ? split(",", local.secondary_gids[each.key]) : null
    }
  }

  root_directory {
    path = "/${each.key}"

    dynamic "creation_info" {
      for_each = try(var.access_points[each.key]["creation_info"]["gid"], "") != "" ? ["true"] : []

      content {
        owner_gid   = var.access_points[each.key]["creation_info"]["gid"]
        owner_uid   = var.access_points[each.key]["creation_info"]["uid"]
        permissions = var.access_points[each.key]["creation_info"]["permissions"]
      }
    }
  }

  tags = var.tags
}

module "security_group" {
  source = "cloudposse/security-group/aws"
  version = "1.0.1"

  enabled = local.security_group_enabled

  security_group_name           = var.security_group_name
  create_before_destroy         = var.create_before_destroy
  security_group_create_timeout = var.security_group_create_timeout
  security_group_delete_timeout = var.security_group_delete_timeout

  security_group_description = var.security_group_description
  allow_all_egress           = true
  rules                      = var.additional_security_group_rules
  rule_matrix = [
    {
      source_security_group_ids = var.allowed_security_group_ids
      cidr_blocks               = var.allowed_cidr_blocks
      rules = [
        {
          key         = "in"
          type        = "ingress"
          from_port   = 2049
          to_port     = 2049
          protocol    = "tcp"
          description = "Allow ingress EFS traffic"
        }
      ]
    }
  ]
  vpc_id = var.vpc_id
}

resource "aws_efs_backup_policy" "policy" {
  count = var.enabled ? 1 : 0

  file_system_id = aws_efs_file_system.default[0].id

  backup_policy {
    status = var.efs_backup_policy_enabled ? "ENABLED" : "DISABLED"
  }
}
