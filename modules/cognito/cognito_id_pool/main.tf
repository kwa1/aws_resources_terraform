resource "aws_cognito_identity_pool" "example_provider" {
  identity_pool_name               = var.pool_name
  allow_unauthenticated_identities = var.allow_unauthenticated_identities
  allow_classic_flow               = var.allow_classic_flow

  dynamic "cognito_identity_providers" {
    for_each = var.identity_providers
    content {
      client_id               = cognito_identity_providers.value.client_id
      provider_name           = cognito_identity_providers.value.provider_name
      server_side_token_check = cognito_identity_providers.value.server_side_token_check
    }
  }

  tags = var.tags
}
