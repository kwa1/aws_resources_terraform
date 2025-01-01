output "ebs_volume_id" {
  description = "The ID of the EBS volume."
  value       = aws_ebs_volume.default.id
}

output "attached_instances" {
  description = "List of instances the volume is attached to."
  value       = var.attach_to_instance ? var.instances : []
}
