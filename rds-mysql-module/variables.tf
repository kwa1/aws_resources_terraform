variable "db_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "engine" {
  description = "Database engine type"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "Instance class for RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "The allocated storage in GBs"
  type        = number
  default     = 20
}

variable "username" {
  description = "Master username for the database"
  type        = string
}

variable "password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
