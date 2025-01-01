variable "pool_name" {
  description = "The name of the Cognito Identity Pool."
  type        = string
}

variable "allow_unauthenticated_identities" {
  description = "Whether the identity pool allows unauthenticated identities."
  type        = bool
  default     = false
}

variable "allow_classic_flow" {
  description = "Whether the identity pool uses the classic flow."
  type        = bool
  default     = false
}

variable "identity_providers" {
  description = <<EOT
A map of identity providers for the identity pool. Each provider should include:
  - client_id
  - provider_name
  - server_side_token_check
EOT
  type = map(object({
    client_id               = string
    provider_name           = string
    server_side_token_check = bool
  }))
  default = {}
}

variable "tags" {
  description = "Tags to associate with the identity pool."
  type        = map(string)
  default     = {}
}
