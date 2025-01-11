AWS Organizations Account and IAM Role Setup
This Terraform configuration automates the creation of a new AWS Organizations account, along with setting up IAM roles (admin and read-only) and configuring AWS CLI profiles for each role.

Prerequisites
Terraform v1.0 or higher
AWS CLI configured with access to create resources in your AWS account
An AWS account with necessary permissions to manage Organizations, IAM, and AWS CLI configurations
Variables
The following input variables are used in the configuration:

account_name (required): The name of the AWS account to be created. This will also be used for naming roles and configuring AWS CLI profiles.
default_region (optional, default: eu-west-1): The AWS region for the new account profiles. You can override this value if necessary.
Resources
The configuration creates the following AWS resources:

AWS Organizations Account:

A new AWS account is created with the provided account_name.
An email is generated based on the account name (e.g., aws+<account_name>@example.com).
IAM Roles:

Admin Role: A role with full permissions to the new AWS account (organization_role).
Read-Only Role: A role with limited permissions (e.g., EC2 and S3 describe and list actions) for read-only access (organization_role_read_only).
AWS CLI Profiles:

Profiles are configured for both the admin and read-only roles in the ~/.aws/config file:
Admin profile: profile <account_name>admin
Read-only profile: profile <account_name>
Outputs
The configuration will output the following information:

account_id: The ID of the newly created AWS account.
admin_role_arn: The ARN of the admin role for the new AWS account.
read_only_role_arn: The ARN of the read-only role for the new AWS account.
Usage
Step 1: Clone the repository
Clone this repository to your local machine or workspace.

bash
Copy code
git clone <repository-url>
cd <repository-directory>
Step 2: Set up Terraform variables
Create a terraform.tfvars file or provide variables via the command line:

hcl
Copy code
account_name = "YourAccountName"
default_region = "us-east-1" # Optional: Use your preferred AWS region
Step 3: Initialize Terraform
Initialize the Terraform working directory:

bash
Copy code
terraform init
Step 4: Plan the changes
Generate and review an execution plan to ensure the resources will be created as expected:

bash
Copy code
terraform plan -var="account_name=YourAccountName"
Step 5: Apply the configuration
Apply the configuration to create the AWS account and IAM roles:

bash
Copy code
terraform apply -var="account_name=YourAccountName"
Step 6: Review outputs
Once the plan has been applied, Terraform will output the following information:

The newly created AWS account ID
The ARNs for both the admin and read-only IAM roles
Step 7: AWS CLI Configuration
The AWS CLI profiles for both roles (<account_name>admin and <account_name>) will be configured automatically in your ~/.aws/config file. You can now use these profiles to interact with the newly created AWS account:

bash
Copy code
aws s3 ls --profile <account_name>admin
aws ec2 describe-instances --profile <account_name>
Cleanup
To destroy the created resources and clean up the environment, run:

bash
Copy code
terraform destroy -var="account_name=YourAccountName"
Notes
The created roles and AWS profiles are essential for managing and interacting with the new AWS account.
The IAM roles have wide permissions (full access for the admin and read-only access for the read-only role). You can further customize the permissions in the aws_iam_role_policy resources.
Be sure to review the AWS account's email configuration, as the generated email address may need adjustments depending on your organization's domain policies.
This README.md file covers all the steps for setting up, applying, and cleaning up the Terraform configuration. Let me know if you'd like to include more specific details or have additional instructions!
