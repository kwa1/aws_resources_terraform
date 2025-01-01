variable "name" {
  description = "The name of the Cognito user pool client."
  type        = string
}

variable "user_pool_id" {
  description = "The ID of the Cognito user pool."
  type        = string
}

variable "generate_secret" {
  description = "Indicates whether a secret key should be generated for the user pool client."
  type        = bool
  default     = false
}

variable "explicit_auth_flows" {
  description = "The explicit authentication flows enabled for the user pool client."
  type        = list(string)
  default     = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
}

variable "read_attributes" {
  description = "List of attributes the application client can read."
  type        = list(string)
  default     = ["email", "name"]
}

variable "write_attributes" {
  description = "List of attributes the application client can write."
  type        = list(string)
  default     = ["email", "name"]
}

variable "supported_identity_providers" {
  description = "List of provider names for the identity providers supported on this client."
  type        = list(string)
  default     = ["COGNITO"]
}

variable "callback_urls" {
  description = "List of allowed callback URLs for the user pool client."
  type        = list(string)
  default     = []
}

variable "logout_urls" {
  description = "List of allowed logout URLs for the user pool client."
  type        = list(string)
  default     = []
}

variable "allowed_oauth_flows" {
  description = "List of allowed OAuth flows for the user pool client."
  type        = list(string)
  default     = ["code", "implicit"]
}

variable "refresh_token_validity" {
  description = "The validity duration of refresh tokens in days."
  type        = number
  default     = 30
}

variable "allowed_oauth_flows_user_pool_client" {
  description = "Specifies whether the client is allowed to follow the OAuth protocol when interacting with Cognito user pools."
  type        = bool
  default     = true
}

variable "allowed_oauth_scopes" {
  description = "List of allowed OAuth scopes."
  type        = list(string)
  default     = ["openid", "email", "profile"]
}

variable "prevent_user_existence_errors" {
  description = "Specifies whether user existence-related errors are prevented."
  type        = string
  default     = "ENABLED"
}

variable "enable_token_revocation" {
  description = "Indicates whether token revocation is enabled for the user pool client."
  type        = bool
  default     = true
}

variable "enable_propagate_additional_user_context_data" {
  description = "Indicates whether additional user context data is propagated."
  type        = bool
  default     = false
}

variable "access_token_validity" {
  description = "The validity duration of access tokens in minutes."
  type        = number
  default     = 60
}

variable "id_token_validity" {
  description = "The validity duration of ID tokens in minutes."
  type        = number
  default     = 60
}

variable "auth_session_validity" {
  description = "The duration of the authentication session in minutes."
  type        = number
  default     = 3
}

variable "token_validity_units" {
  description = "A map specifying the validity units for tokens (e.g., hours or days)."
  type        = map(object({
    access_token  = optional(string, "hours")
    id_token      = optional(string, "hours")
    refresh_token = optional(string, "days")
  }))
  default = {}
}
