# Name of the key pair
variable "key_name" {
  description = "Name of the EC2 key pair and associated resources."
  type        = string
}

# RSA key size (2048 or 4096 bits)
variable "rsa_bits" {
  description = "Bit length of the RSA private key."
  type        = number
  default     = 4096
}

# Environment (e.g., dev, staging, prod)
variable "environment" {
  description = "Environment tag for resource identification."
  type        = string
  default     = "ea"
}

