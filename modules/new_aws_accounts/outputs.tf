data "aws_caller_identity" "current" {}

output "account_id" {
  value       = aws_organizations_account.account.id
  description = "The ID of the created AWS account"
}

output "admin_role_arn" {
  value       = aws_iam_role.organization_role.arn
  description = "The ARN of the admin role for the new AWS account"
}

output "read_only_role_arn" {
  value       = aws_iam_role.organization_role_read_only.arn
  description = "The ARN of the read-only role for the new AWS account"
}
