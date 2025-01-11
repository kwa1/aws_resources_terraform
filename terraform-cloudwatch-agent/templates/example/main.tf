module "cloudwatch_agent" {
  source                  = "./terraform-cloudwatch-agent"
  name_prefix             = "example"
  ami_id                  = "ami-0c55b159cbfafe1f0"
  instance_type           = "t2.micro"
  cw_agent_config_source  = "s3"
  s3_bucket               = "my-bucket-name"
  s3_key                  = "cw-agent/amazon-cloudwatch-agent.json"
  local_path              = "/opt/local-config/amazon-cloudwatch-agent.json"
}
