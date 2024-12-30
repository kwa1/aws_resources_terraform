variable "cluster_name" {
  description = "Name of the Aurora cluster"
  type        = string
}

variable "engine" {
  description = "Database engine type"
  type        = string
  default     = "aurora-mysql"
}

variable "engine_version" {
  description = "Aurora MySQL engine version"
  type        = string
  default     = "5.7.mysql_aurora.2.10.2"
}

variable "username" {
  description = "Master username for the Aurora cluster"
  type        = string
}

variable "password" {
  description = "Master password for the Aurora cluster"
  type        = string
  sensitive   = true
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Aurora cluster"
  type        = list(string)
}

variable "instance_class" {
  description = "Instance class for Aurora cluster"
  type        = string
  default     = "db.r5.large"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
