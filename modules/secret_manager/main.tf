resource "aws_kms_key" "secrets_encryption" {
  description             = "KMS key for encrypting Secrets Manager secrets."
  deletion_window_in_days = 30

  tags = {
    Environment = "Production"
    Application = "SecretsManager"
  }
}

resource "aws_secretsmanager_secret" "this" {
  name                     = var.secret_name
  description              = "Managed secret for ${var.secret_name}"
  recovery_window_in_days  = 30
  kms_key_id               = aws_kms_key.secrets_encryption.arn
  tags = {
    Environment = "Production"
    Application = "SecretsManager"
  }
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode({
    username = "example-user"
    password = "example-password"
  })
}
resource "aws_iam_role" "rotation_lambda_role" {
  name = "${var.secret_name}_rotation_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "rotation_lambda_policy" {
  name = "${var.secret_name}_rotation_lambda_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue",
          "secretsmanager:UpdateSecretVersionStage",
          "secretsmanager:PutSecretValue",
          "secretsmanager:CancelRotateSecret"
        ],
        Effect   = "Allow",
        Resource = aws_secretsmanager_secret.this.arn
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rotation_lambda_policy_attachment" {
  role       = aws_iam_role.rotation_lambda_role.name
  policy_arn = aws_iam_policy.rotation_lambda_policy.arn
}

resource "aws_lambda_function" "rotation_function" {
  filename         = ""
  s3_bucket        = var.rotation_lambda_s3_bucket
  s3_key           = var.rotation_lambda_s3_key
  function_name    = "${var.secret_name}_rotation_lambda"
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  role             = aws_iam_role.rotation_lambda_role.arn
  timeout          = 15
  memory_size      = 128

  environment {
    variables = {
      SECRET_ID = aws_secretsmanager_secret.this.id
    }
  }
}

resource "aws_secretsmanager_secret_rotation" "this" {
  secret_id           = aws_secretsmanager_secret.this.id
  rotation_lambda_arn = aws_lambda_function.rotation_function.arn
  rotation_rules {
    automatically_after_days = lookup(each.value, "automatically_after_days", var.automatically_after_days)
  }
  depends_on = [aws_secretsmanager_secret.this]

  lifecycle {
    ignore_changes = [
      secret_id,
    ]
  }
}
