resource "aws_iam_role" "cw_agent_role" {
  name = "${var.name_prefix}-cw-agent-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "cw_agent_policy" {
  name        = "${var.name_prefix}-cw-agent-policy"
  description = "Policy for CloudWatch Agent"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "cloudwatch:PutMetricData",
          "ec2:DescribeTags",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ssm:GetParameter"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cw_policy_attachment" {
  role       = aws_iam_role.cw_agent_role.name
  policy_arn = aws_iam_policy.cw_agent_policy.arn
}

resource "aws_iam_instance_profile" "cw_agent_instance_profile" {
  name = "${var.name_prefix}-cw-agent-instance-profile"
  role = aws_iam_role.cw_agent_role.name
}

resource "aws_instance" "cw_agent_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  iam_instance_profile = aws_iam_instance_profile.cw_agent_instance_profile.name

  user_data = templatefile("${path.module}/templates/user_data.sh.tpl", {
    cw_agent_config_source = var.cw_agent_config_source
    s3_bucket              = var.s3_bucket
    s3_key                 = var.s3_key
    local_path             = var.local_path
  })

  tags = {
    Name = "${var.name_prefix}-cw-agent-instance"
  }
}
