resource "aws_cognito_user_pool_client" "client" {
  name                                          = var.name
  user_pool_id                                  = var.user_pool_id
  generate_secret                               = var.generate_secret
  explicit_auth_flows                           = var.explicit_auth_flows
  read_attributes                               = var.read_attributes
  write_attributes                              = var.write_attributes
  supported_identity_providers                  = var.supported_identity_providers
  callback_urls                                 = var.callback_urls
  logout_urls                                   = var.logout_urls
  allowed_oauth_flows                           = var.allowed_oauth_flows
  refresh_token_validity                        = var.refresh_token_validity
  allowed_oauth_flows_user_pool_client          = var.allowed_oauth_flows_user_pool_client
  allowed_oauth_scopes                          = var.allowed_oauth_scopes
  prevent_user_existence_errors                 = var.prevent_user_existence_errors
  enable_token_revocation                       = var.enable_token_revocation
  enable_propagate_additional_user_context_data = var.enable_propagate_additional_user_context_data
  access_token_validity                         = var.access_token_validity
  id_token_validity                             = var.id_token_validity
  auth_session_validity                         = var.auth_session_validity

  dynamic "token_validity_units" {
    for_each = var.token_validity_units != null ? [for key, value in var.token_validity_units : { key = key, value = value }] : []
    content {
      access_token  = lookup(token_validity_units.value, "access_token", "hours")
      id_token      = lookup(token_validity_units.value, "id_token", "hours")
      refresh_token = lookup(token_validity_units.value, "refresh_token", "days")
    }
  }
}
