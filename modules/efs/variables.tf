variable "enabled" {
  description = "Enable or disable EFS provisioning."
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS Key ID for encryption. Defaults to AWS managed key if not specified."
  type        = string
  default     = null
}

variable "availability_zone_name" {
  description = "The AZ where the file system is accessible."
  type        = string
  default     = null
}

variable "performance_mode" {
  description = "Performance mode for the file system."
  type        = string
  default     = "generalPurpose"
}

variable "provisioned_throughput_in_mibps" {
  description = "Provisioned throughput in MiB/s."
  type        = number
  default     = null
}

variable "throughput_mode" {
  description = "Throughput mode for the file system."
  type        = string
  default     = "bursting"
}

variable "subnets" {
  description = "List of subnet IDs for mount targets."
  type        = list(string)
}

variable "additional_security_group_ids" {
  description = "Additional security group IDs to associate with the mount target."
  type        = list(string)
  default     = []
}

variable "efs_backup_policy_enabled" {
  description = "Enable or disable EFS backup policy."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}
