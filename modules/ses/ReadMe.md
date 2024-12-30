Example Usage for Verified Email

module "ses" {
  source          = "./ses-module"
  region          = "us-east-1"
  email_identity  = "noreply@sakano.com"
  manage_dns_records = false

  tags = {
    Application = "EmailService"
    Environment = "Production"
  }
}
Example Usage for Domain-Based SES with Route 53 Management
module "ses" {
  source          = "./ses-module"
  domain_name     = "sakano.com"
  route53_zone_id = "Z3P5QSUBK4POTI"
  region          = "us-east-1"

  tags = {
    Application = "EmailService"
    Environment = "Production"
  }
}
