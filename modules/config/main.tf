resource "aws_config_configuration_recorder" "main" {
  name     = var.config_recorder_name
  role_arn = var.config_role_arn

  recording_group {
    all_supported             = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "main" {
  name           = var.config_delivery_channel_name
  s3_bucket_name = var.config_bucket_name
}

resource "aws_config_config_rule" "required_tags" {
  count = var.enable_config_rule ? 1 : 0

  name = "required-tags"
  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }

  scope {
    compliance_resource_types = ["AWS::EC2::Instance"]
  }

  input_parameters = <<-JSON
    {
      "tag1Key": "Environment",
      "tag2Key": "Owner"
    }
  JSON
}
