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

Example Usage
With Route 53 DNS Management
hcl
Copy code
module "ses" {
  source          = "./ses-module"
  user            = "noreply"
  email_domain    = "sakano.com"
  region          = "us-east-1"
  route53_zone_id = "Z3P5QSUBK4POTI" # Your Route 53 Hosted Zone ID
  manage_dns_records = true

  tags = {
    Application = "EmailService"
    Environment = "Production"
  }
}
Without Route 53 DNS Management (Manual DNS)
hcl
Copy code
module "ses" {
  source             = "./ses-module"
  user               = "noreply"
  email_domain       = "sakano.com"
  region             = "us-east-1"
  manage_dns_records = false # Skip DNS management in Route 53

  tags = {
    Application = "EmailService"
    Environment = "Production"
  }
}
In this case, after deployment, manually verify the email identity and set up DKIM records 
through your DNS provider using the verification token and DKIM tokens provided in the output.

