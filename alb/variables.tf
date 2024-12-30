# Load Balancer Variables
variable "name" {
  type        = string
  description = "Name of the load balancer."
}

variable "internal" {
  type        = bool
  description = "Whether the load balancer is internal."
  default     = false
}

variable "lb_type" {
  type        = string
  description = "Type of the load balancer (e.g., application, network)."
  default     = "application"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups associated with the load balancer."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets associated with the load balancer."
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Enable deletion protection for the load balancer."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the load balancer."
}

# Target Group Variables
variable "target_group_name" {
  type        = string
  description = "Name of the target group."
}

variable "target_group_port" {
  type        = number
  description = "Port for the target group."
}

variable "target_group_protocol" {
  type        = string
  description = "Protocol for the target group."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the load balancer is deployed."
}

variable "target_type" {
  type        = string
  description = "Target type for the target group (e.g., instance, ip, lambda)."
}

# Health Check Variables
variable "health_check_interval" {
  type        = number
  description = "Interval for health checks."
  default     = 30
}

variable "health_check_path" {
  type        = string
  description = "Path for health checks."
  default     = "/"
}

variable "health_check_port" {
  type        = number
  description = "Port for health checks."
  default     = 80
}

variable "health_check_protocol" {
  type        = string
  description = "Protocol for health checks."
  default     = "HTTP"
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
variable "listener_http_port" {
  type        = number
  description = "Port for HTTP listener."
  default     = 80
}

variable "listener_http_protocol" {
  type        = string
  description = "Protocol for HTTP listener."
  default     = "HTTP"
}

variable "listener_https_port" {
  type        = number
  description = "Port for HTTPS listener."
  default     = 443
}

variable "listener_https_protocol" {
  type        = string
  description = "Protocol for HTTPS listener."
  default     = "HTTPS"
}

variable "ssl_policy" {
  type        = string
  description = "SSL policy for HTTPS listener."
  default     = "ELBSecurityPolicy-2016-08"
}

variable "certificate_arn" {
  type        = string
  description = "ARN of the SSL certificate for HTTPS listener."
}

# Default Action Variables
variable "default_action_type" {
  type        = string
  description = "Type of default action for the listener."
  default     = "fixed-response"
}

variable "fixed_response_status_code" {
  type        = string
  description = "Status code for fixed response."
  default     = "200"
}

variable "fixed_response_content_type" {
  type        = string
  description = "Content type for fixed response."
  default     = "text/plain"
}

variable "fixed_response_message_body" {
  type        = string
  description = "Message body for fixed response."
  default     = "OK"
}
