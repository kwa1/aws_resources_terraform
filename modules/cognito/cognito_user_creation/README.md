File Structure
bash
Copy code
cognito_user_creation/
├── main.tf       # Defines resources for user creation and password generation
├── variables.tf  # Defines input variables
├── outputs.tf    # Outputs information about created users
Usage
Example Configuration

module "cognito_user_creation" {
  source = "./cognito_user_creation"

  users = {
    user1 = {
      user_pool_name  = "example-pool"
      username        = "user1@example.com"
      email           = "user1@example.com"
      email_verified  = true
      password_length = 12
      special         = true
      number          = true
      upper           = true
    }

    user2 = {
      user_pool_name  = "example-pool"
      username        = "user2@example.com"
      email           = "user2@example.com"
    }
  }
}
Inputs
Variable	Description	Type	Default	Required
users	A map of users to be created, with configuration for each user.	map(object)	n/a	yes
User Object Attributes
Attribute	Description	Type	Default	Required
user_pool_name	Name of the Cognito User Pool where the user will be created.	string	n/a	yes
username	Username for the Cognito user.	string	n/a	yes
email	Email address for the Cognito user.	string	n/a	yes
email_verified	Whether the user's email is verified.	bool	true	no
password_length	Length of the generated temporary password.	number	10	no
special	Include special characters in the password.	bool	false	no
number	Include numeric characters in the password.	bool	true	no
upper	Include uppercase characters in the password.	bool	true	no
Outputs
Output Name	Description
cognito_users	List of created Cognito users with their usernames and IDs.
temporary_passwords	Generated temporary passwords for the created Cognito users.
Notes
Password Complexity: Password policies can be customized per user using optional attributes like special, number, and upper.
Lifecycle Management: Users are protected from accidental deletion with prevent_destroy lifecycle rules.
Email Verification: The default behavior marks user emails as verified; this can be overridden as needed.
Dynamic Scaling: Use for_each to handle an arbitrary number of users dynamically.
Requirements
AWS Terraform Provider configured in your environment.
Existing AWS Cognito User Pools to associate the users with.
Best Practices
Use secure email addresses and enforce strong password policies.
Keep track of temporary passwords securely for user onboarding.
Regularly review and update user attributes for compliance and security.
License
This module is licensed under the MIT License.

