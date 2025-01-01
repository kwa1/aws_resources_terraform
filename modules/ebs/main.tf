resource "aws_ebs_volume" "default" {
  availability_zone   = var.availability_zone
  size                = local.volume_size
  type                = local.volume_type
  encrypted           = true
  kms_key_id          = var.kms_key_id
  iops                = local.iops
  throughput          = local.throughput
  multi_attach_enabled = local.multi_attach_enabled
  tags                = merge(var.tags, { "Name" = var.name })
}

resource "aws_volume_attachment" "default" {
  count         = var.attach_to_instance && length(var.instances) > 0 ? length(var.instances) : 0
  device_name   = local.device_name
  volume_id     = aws_ebs_volume.default.id
  instance_id   = var.instances[count.index]
  force_detach  = local.force_detach
}
