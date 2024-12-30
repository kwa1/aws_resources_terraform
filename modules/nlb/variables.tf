# Load Balancer Variables
variable "name" {
  type        = string
  description = "Name of the network load balancer."
}

variable "internal" {
  type        = bool
  description = "Whether the NLB is internal."
  default     = false
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets associated with the NLB."
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Enable deletion protection for the NLB."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the NLB."
}

# Target Group Variables
variable "target_group_name" {
  type        = string
  description = "Name of the target group."
}

variable "target_group_port" {
  type        = number
  description = "Port for the target group."
  default     = 443
}

variable "target_group_protocol" {
  type        = string
  description = "Protocol for the target group (e.g., TCP, UDP, TLS)."
  default     = "TLS"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the NLB is deployed."
}

variable "target_type" {
  type        = string
  description = "Target type for the target group (e.g., instance, ip, lambda)."
  default     = "instance"
}

# Health Check Variables
variable "health_check_enabled" {
  type        = bool
  description = "Enable health checks for the target group."
  default     = true
}

variable "health_check_interval" {
  type        = number
  description = "Interval for health checks."
  default     = 30
}

variable "health_check_path" {
  type        = string
  description = "Path for health checks (optional for TCP/UDP)."
  default     = "/"
}

variable "health_check_port" {
  type        = number
  description = "Port for health checks."
  default     = 443
}

variable "health_check_protocol" {
  type        = string
  description = "Protocol for health checks."
  default     = "HTTPS"
}

variable "health_check_timeout" {
  type        = number
  description = "Timeout for health checks."
  default     = 5
}

variable "healthy_threshold" {
  type        = number
  description = "Healthy threshold for health checks."
  default     = 3
}

variable "unhealthy_threshold" {
  type        = number
  description = "Unhealthy threshold for health checks."
  default     = 3
}

# Listener Variables
variable "listener_port" {
  type        = number
  description = "Port for the listener."
  default     = 443
}

variable "ssl_policy" {
  type        = string
  description = "SSL policy for the TLS listener."
  default     = "ELBSecurityPolicy-2016-08"
}

variable "certificate_arn" {
  type        = string
  description = "ARN of the SSL certificate for the listener."
}
