resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.kms_key_arn
  }

  # Enable repository scanning for vulnerabilities (good security practice)
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(var.tags, { Name = var.repository_name })
}

# Optional lifecycle policy for image cleanup
resource "aws_ecr_lifecycle_policy" "this" {
  repository_name = aws_ecr_repository.this.name
  policy          = var.lifecycle_policy
  depends_on      = [aws_ecr_repository.this]
}

# IAM policy for repository access with least privilege
resource "aws_iam_policy" "this" {
  name        = "${var.repository_name}-policy"
  description = "Policy to allow access to ECR repository ${var.repository_name}"
  policy      = var.iam_policy_document
  depends_on  = [aws_ecr_repository.this]
}

# Attach the IAM policy to the IAM role or user
resource "aws_iam_role_policy_attachment" "this" {
  role       = var.iam_role
  policy_arn = aws_iam_policy.this.arn
  depends_on = [aws_ecr_repository.this]
}

# CloudWatch logging (for auditing)
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/ecr/repository/${var.repository_name}"
  retention_in_days = 30
}

resource "aws_ecr_repository_event_configuration" "this" {
  repository_name = aws_ecr_repository.this.name

  event_configuration {
    event_type = "PUSH"
    destination {
      cloudwatch_logs {
        log_group = aws_cloudwatch_log_group.this.name
      }
    }
  }
}
