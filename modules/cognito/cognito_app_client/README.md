Cognito App Client Terraform Module
This Terraform module creates and manages a Cognito User Pool Client for AWS Cognito. The client enables applications to authenticate users and handle OAuth flows securely and dynamically.

Features
Supports dynamic configurations using for_each and lookup.
Allows customization of OAuth flows, scopes, and token validity.
Supports generating a secret key for the client.
Provides flexibility in managing callback and logout URLs.
Fully integrated with AWS Cognito best practices.
Usage
module "cognito_app_client" {
  source = "./modules/cognito_app_client"

  name                                          = "my-app-client"
  user_pool_id                                  = "us-east-1_XXXXXXXXX"
  generate_secret                               = true
  explicit_auth_flows                           = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  read_attributes                               = ["email", "name"]
  write_attributes                              = ["email", "name"]
  supported_identity_providers                  = ["COGNITO"]
  callback_urls                                 = ["https://example.com/callback"]
  logout_urls                                   = ["https://example.com/logout"]
  allowed_oauth_flows                           = ["code", "implicit"]
  refresh_token_validity                        = 30
  allowed_oauth_flows_user_pool_client          = true
  allowed_oauth_scopes                          = ["openid", "email", "profile"]
  prevent_user_existence_errors                 = "ENABLED"
  enable_token_revocation                       = true
  enable_propagate_additional_user_context_data = false
  access_token_validity                         = 60
  id_token_validity                             = 60
  auth_session_validity                         = 3
  token_validity_units = {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "days"
  }
}
Inputs
Name	Description	Type	Default	Required
name	The name of the Cognito user pool client.	string	n/a	Yes
user_pool_id	The ID of the Cognito user pool.	string	n/a	Yes
generate_secret	Indicates whether a secret key should be generated for the client.	bool	false	No
explicit_auth_flows	The explicit authentication flows enabled for the client.	list(string)	["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]	No
read_attributes	List of attributes the client can read.	list(string)	["email", "name"]	No
write_attributes	List of attributes the client can write.	list(string)	["email", "name"]	No
supported_identity_providers	List of identity providers supported by the client.	list(string)	["COGNITO"]	No
callback_urls	List of allowed callback URLs.	list(string)	[]	No
logout_urls	List of allowed logout URLs.	list(string)	[]	No
allowed_oauth_flows	List of allowed OAuth flows.	list(string)	["code", "implicit"]	No
refresh_token_validity	The validity duration of refresh tokens (in days).	number	30	No
allowed_oauth_flows_user_pool_client	Whether the client follows the OAuth protocol with the user pool.	bool	true	No
allowed_oauth_scopes	List of allowed OAuth scopes.	list(string)	["openid", "email", "profile"]	No
prevent_user_existence_errors	Whether user existence-related errors are prevented.	string	"ENABLED"	No
enable_token_revocation	Indicates if token revocation is enabled for the client.	bool	true	No
enable_propagate_additional_user_context_data	Indicates if additional user context data is propagated.	bool	false	No
access_token_validity	Validity duration of access tokens (in minutes).	number	60	No
id_token_validity	Validity duration of ID tokens (in minutes).	number	60	No
auth_session_validity	Duration of the authentication session (in minutes).	number	3	No
token_validity_units	A map specifying the validity units for tokens.	map(object)	{}	No
Outputs
Name	Description
client_id	The ID of the created Cognito user pool client.
client_name	The name of the created Cognito user pool client.
client_secret	The secret of the created Cognito user pool client (if generate_secret is enabled).
Notes
Ensure you provide valid callback and logout URLs to avoid errors in OAuth configuration.
The module allows dynamic token validity units, making it adaptable for varying application needs.
If generate_secret is enabled, the client_secret output provides the generated secret key.
License
This module is licensed under the MIT License.
