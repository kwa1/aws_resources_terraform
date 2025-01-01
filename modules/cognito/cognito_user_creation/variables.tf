variable "users" {
  description = "List of users to create in the Cognito user pool."
  type = map(object({
    user_pool_name   = string
    username         = string
    email            = string
    email_verified   = optional(bool)
    password_length  = optional(number)
    special          = optional(bool)
    number           = optional(bool)
    upper            = optional(bool)
  }))
}
