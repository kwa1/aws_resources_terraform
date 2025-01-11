variable "name_prefix" {
  description = "Prefix for naming AWS resources"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "cw_agent_config_source" {
  description = "Source for the CloudWatch Agent config. Options: 'local' or 's3'"
  type        = string
  default     = "local"
}

variable "s3_bucket" {
  description = "S3 bucket name for the CloudWatch Agent configuration"
  type        = string
  default     = ""
}

variable "s3_key" {
  description = "S3 key for the CloudWatch Agent configuration"
  type        = string
  default     = ""
}

variable "local_path" {
  description = "Local path for the CloudWatch Agent configuration"
  type        = string
  default     = "/opt/local-config/amazon-cloudwatch-agent.json"
}
