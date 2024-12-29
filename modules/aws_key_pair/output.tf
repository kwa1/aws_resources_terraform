# Output directory for the private key file
variable "output_dir" {
  description = "Directory to store the generated .pem file."
  type        = string
  default     = path.cwd  # Defaults to the current working directory
}
