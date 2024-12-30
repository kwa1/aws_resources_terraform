variable "repository_name" {
  description = "The name of the ECR repository."
  type        = string
}

variable "image_tag_mutability" {
  description = "The image tag mutability setting for the repository. Valid values are 'MUTABLE' and 'IMMUTABLE'."
  type        = string
  default     = "IMMUTABLE"
}

variable "encryption_type" {
  description = "The encryption type for the repository. Valid values are 'AES256' or 'KMS'."
  type        = string
  default     = "AES256"
}

variable "tags" {
  description = "Tags to assign to the repository."
  type        = map(string)
  default     = {}
}

variable "lifecycle_policy" {
  description = "The lifecycle policy for the repository in JSON format."
  type        = string
  default     = "{}"  # Empty policy by default
}

variable "iam_policy_document" {
  description = "IAM policy document in JSON format for repository access."
  type        = string
  default     = "{}"  # Empty policy by default
}

variable "iam_role" {
  description = "IAM role to attach the policy to."
  type        = string
  default     = ""  # No IAM role by default
}
