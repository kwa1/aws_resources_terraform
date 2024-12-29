bucket           = "my-terraform-s3-bucket"
bucket_prefix    = "tf-"
tags             = { Team = "DevOps", Project = "Terraform S3" }
logging          = { target_bucket = "my-log-bucket", target_prefix = "logs/" }
create_bucket    = true
enable_bucket_creation = true
force_destroy    = true
environment      = "production"
aws_region       = "us-west-2"
