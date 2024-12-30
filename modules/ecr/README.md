# ECR Module

This Terraform module creates an ECR repository with optional lifecycle policies and IAM permissions.

## Usage

module "ecr" {
  source             = "./modules/ecr"
  repository_name    = "my-repository"
  image_tag_mutability = "IMMUTABLE"
  encryption_type    = "AES256"
  tags               = {
    Environment = "Production"
  }
  lifecycle_policy   = <<EOF
{
  "rule": [
    {
      "rulePriority": 1,
      "description": "Retain images for 30 days",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 10
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
  iam_policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ecr:GetAuthorizationToken",
      "Resource": "*"
    }
  ]
}
EOF
  iam_role           = "my-iam-role"
}


Inputs
Name	Description	Type	Default
repository_name	The name of the ECR repository.	string	N/A
image_tag_mutability	The image tag mutability setting for the repository.	string	IMMUTABLE
encryption_type	The encryption type for the repository.	string	AES256
tags	Tags to assign to the repository.	map(string)	{}
lifecycle_policy	The lifecycle policy for the repository in JSON format.	string	{}
iam_policy_document	IAM policy document in JSON format for repository access.	string	{}
iam_role	IAM role to attach the policy to.	string	""
Outputs
Name	Description
repository_url	The URL of the ECR repository.
repository_arn	The ARN of the ECR repository.
repository_id	The ID of the ECR repository.
vbnet
Copy code

### How to Use the ECR Module

Once the module is created, you can use it in your main Terraform configuration as follows:

```hcl
module "ecr" {
  source             = "./modules/ecr"
  repository_name    = "my-ecr-repository"
  image_tag_mutability = "IMMUTABLE"
  encryption_type    = "AES256"
  tags               = {
    Environment = "Production"
  }
  lifecycle_policy   = <<EOF
{
  "rule": [
    {
      "rulePriority": 1,
      "description": "Expire images older than 30 days",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 10
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
  iam_policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ecr:GetAuthorizationToken",
      "Resource": "*"
    }
  ]
}
EOF
  iam_role           = "my-iam-role"
}

#Summary
#This module is designed to be dynamic and reusable, allowing you to create an ECR repository
#with options for encryption, lifecycle policies, and IAM permissions. You can customize
#the repository configuration by adjusting the input variables when calling the module
