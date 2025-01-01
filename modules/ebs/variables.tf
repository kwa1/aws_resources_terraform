variable "availability_zone" {
  description = "The AZ where the EBS volume will be created."
  type        = string
}

variable "volume_size" {
  description = "The size of the EBS volume in GiB."
  type        = number
  default     = 20
}

variable "volume_type" {
  description = "The type of EBS volume (gp2, gp3, io1, io2, sc1, st1)."
  type        = string
  default     = "gp3"
}

variable "kms_key_id" {
  description = "KMS Key ID for encryption. Defaults to AWS managed key if not specified."
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the EBS volume for tagging purposes."
  type        = string
  default     = "ebs-volume"
}

variable "iops" {
  description = "The number of IOPS for io1, io2, or gp3 volumes."
  type        = number
  default     = null
}

variable "throughput" {
  description = "Throughput in MiB/s for gp3 volumes."
  type        = number
  default     = null
}

variable "multi_attach_enabled" {
  description = "Enable Multi-Attach support for the volume."
  type        = bool
  default     = false
}

variable "device_name" {
  description = "The device name for the volume (e.g., /dev/xvdf)."
  type        = string
  default     = "/dev/xvdf"
}

variable "instances" {
  description = "List of instance IDs to attach the volume to."
  type        = list(string)
  default     = []
}

variable "attach_to_instance" {
  description = "Whether to attach the volume to instances or not."
  type        = bool
  default     = false
}

variable "force_detach" {
  description = "Force detachment of the volume during an update if it is attached."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}
