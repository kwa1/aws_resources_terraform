resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  encryption_configuration {
    encryption_type = var.encryption_type
  }

  tags = merge(var.tags, { Name = var.repository_name })
}

# Optional lifecycle policy for image cleanup
resource "aws_ecr_lifecycle_policy" "this" {
  repository_name = aws_ecr_repository.this.name
  policy          = var.lifecycle_policy
  depends_on      = [aws_ecr_repository.this]
}

# Optional IAM Policy for granting access to the ECR repository
resource "aws_iam_policy" "this" {
  name        = "${var.repository_name}-policy"
  description = "Policy to allow access to ECR repository ${var.repository_name}"
  policy      = var.iam_policy_document
  depends_on  = [aws_ecr_repository.this]
}

# Optional IAM Role or User association
resource "aws_iam_role_policy_attachment" "this" {
  role       = var.iam_role
  policy_arn = aws_iam_policy.this.arn
  depends_on = [aws_ecr_repository.this]
}
