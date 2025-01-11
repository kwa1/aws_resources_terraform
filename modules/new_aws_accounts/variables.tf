variable "account_name" {
  description = "Name of the AWS account to create"
  type        = string
}

variable "default_region" {
  description = "Default AWS region for the new account profiles"
  type        = string
  default     = "eu-west-1"
}
