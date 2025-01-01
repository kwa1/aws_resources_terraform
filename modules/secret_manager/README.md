## AWS Secrets Manager Terraform Module

This Terraform module provisions and manages an AWS Secrets Manager secret with periodic rotation using an AWS Lambda function. It adheres to the AWS Well-Architected Framework by implementing security, reliability, and operational best practices.

### Features

- Creates a Secrets Manager secret with recovery and versioning.
- Encrypts secrets using a dedicated AWS KMS key.
- Sets up periodic rotation using a custom AWS Lambda function.
- Configures IAM roles and policies for secure access control.
- Outputs key identifiers for integration and reference.

### File Structure

- `main.tf`: Contains the primary resource definitions.
- `variables.tf`: Defines input variables for customization.
- `outputs.tf`: Outputs key identifiers for the created resources.
- `locals.tf`: Placeholder for reusable local values.

### Usage

```hcl
module "secrets_manager" {
  source = "./path-to-module"

  secret_name                = "my-secret"
  rotation_lambda_s3_bucket = "my-bucket"
  rotation_lambda_s3_key    = "lambda/rotation.zip"
  rotation_interval_days    = 30
}
```

### Inputs

| Name                        | Description                                        | Type   | Default | Required |
|-----------------------------|----------------------------------------------------|--------|---------|----------|
| `secret_name`               | Name of the secret to be managed.                 | string | n/a     | yes      |
| `rotation_lambda_s3_bucket` | S3 bucket containing the Lambda rotation code.    | string | n/a     | yes      |
| `rotation_lambda_s3_key`    | S3 key (path) for the Lambda rotation code.       | string | n/a     | yes      |
| `rotation_interval_days`    | Days after which the secret is rotated.           | number | 30      | no       |

### Outputs

| Name                  | Description                             |
|-----------------------|-----------------------------------------|
| `secret_arn`          | ARN of the created secret.             |
| `kms_key_id`          | KMS key ID used for encrypting secrets.|
| `lambda_function_name`| Name of the Lambda rotation function.  |

### Requirements

- AWS provider configured in your Terraform environment.
- An S3 bucket with the Lambda function code.

### Notes

- Ensure that the Lambda rotation function adheres to the Secrets Manager rotation interface.
- Modify IAM policies for specific access requirements.

### License

This module is licensed under the MIT License.
