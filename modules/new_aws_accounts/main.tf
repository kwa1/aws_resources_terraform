provider "aws" {
  region = var.default_region
}

data "aws_caller_identity" "current" {}

resource "aws_organizations_account" "account" {
  name                       = var.account_name
  email                      = "aws+${lower(var.account_name)}@example.com"
  iam_user_access_to_billing = "ALLOW"
  role_name                  = "${var.account_name}OrganizationRole"

  lifecycle {
    ignore_changes = [role_name, iam_user_access_to_billing]
  }
}

resource "aws_iam_role" "organization_role" {
  name               = "${aws_organizations_account.account.name}OrganizationRole"
  assume_role_policy = <<-POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "organization_role_policy" {
  role   = aws_iam_role.organization_role.name
  policy = <<-POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "organization_role_read_only" {
  name               = "${aws_organizations_account.account.name}OrganizationRoleReadOnly"
  assume_role_policy = <<-POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "organization_role_read_only_policy" {
  role   = aws_iam_role.organization_role_read_only.name
  policy = <<-POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "s3:ListBucket",
        "s3:GetObject"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "null_resource" "configure_aws_cli" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "\n[profile ${aws_organizations_account.account.name}admin]" >> ~/.aws/config
      echo "role_arn = arn:aws:iam::${aws_organizations_account.account.id}:role/${aws_organizations_account.account.name}OrganizationRole" >> ~/.aws/config
      echo "source_profile = default" >> ~/.aws/config
      echo "region = ${var.default_region}" >> ~/.aws/config

      echo "\n[profile ${aws_organizations_account.account.name}]" >> ~/.aws/config
      echo "role_arn = arn:aws:iam::${aws_organizations_account.account.id}:role/${aws_organizations_account.account.name}OrganizationRoleReadOnly" >> ~/.aws/config
      echo "source_profile = default" >> ~/.aws/config
      echo "region = ${var.default_region}" >> ~/.aws/config
    EOT
  }
}
