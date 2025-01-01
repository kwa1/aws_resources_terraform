Cognito Identity Pool Terraform Module
Description
This Terraform module creates and manages an AWS Cognito Identity Pool. The identity pool integrates with various identity providers to allow unauthenticated and authenticated access to AWS resources.

Features
Supports multiple identity providers via a dynamic block.
Configurable options for allowing unauthenticated identities and classic flows.
Fully customizable with tags for resource organization.
Usage
hcl
Copy code
module "cognito_identity_pool" {
  source = "./modules/cognito_identity_pool"

  pool_name                       = "my-identity-pool"
  allow_unauthenticated_identities = true
  allow_classic_flow               = false
  identity_providers = {
    cognito_provider = {
      client_id               = "example_client_id"
      provider_name           = "cognito-idp.us-east-1.amazonaws.com/us-east-1_example"
      server_side_token_check = true
    }
  }
  tags = {
    Environment = "dev"
    Project     = "example"
  }
}
Inputs
Name	Description	Type	Default	Required
pool_name	The name of the Cognito Identity Pool.	string	n/a	Yes
allow_unauthenticated_identities	Whether unauthenticated identities are allowed.	bool	false	No
allow_classic_flow	Whether the identity pool uses the classic flow.	bool	false	No
identity_providers	Map of identity providers for the identity pool.	map(object)	{}	No
tags	A map of tags to associate with the identity pool.	map(string)	{}	No
Outputs
Name	Description
identity_pool_id	The ID of the created Cognito Identity Pool.
identity_pool_name	The name of the created Cognito Identity Pool.
Notes
Ensure identity_providers includes valid provider configurations.
For using unauthenticated identities, you need to configure roles and permissions for unauthenticated access.
License
This module is licensed under the MIT License.

