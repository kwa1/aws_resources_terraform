variable "secret_name" {
  description = "Name of the secret to be managed."
  type        = string
}

variable "rotation_lambda_s3_bucket" {
  description = "S3 bucket containing the Lambda rotation function code."
  type        = string
}

variable "rotation_lambda_s3_key" {
  description = "S3 key (path) for the Lambda rotation function code."
  type        = string
}

variable "rotation_interval_days" {
  description = "Number of days after which the secret should be rotated."
  type        = number
  default     = 30
}

variable "automatically_after_days" {
  description = "Default number of days for secret rotation if not specified."
  type        = number
  default     = 30
}
