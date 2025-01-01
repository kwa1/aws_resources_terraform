output "efs_id" {
  description = "EFS File System ID"
  value       = aws_efs_file_system.default[0].id
}

output "efs_arn" {
  description = "EFS File System ARN"
  value       = aws_efs_file_system.default[0].arn
}

output "efs_mount_target_ids" {
  description = "EFS Mount Target IDs"
  value       = aws_efs_mount_target.default[*].id
}
