AWS Elastic File System (EFS) Terraform Module
This Terraform module provisions an Amazon Elastic File System (EFS) with robust configurations aligned with the AWS Well-Architected Framework.
It includes features for encryption, lifecycle policies, backup integration, and secure access using security groups.

Features
Automatically encrypted EFS.
Customizable performance and throughput modes.
Lifecycle management for storage tiers.
Optional integration with backup policies.
Secure access control via security groups.
Configurable DNS for EFS mount targets.
File Structure
main.tf: Core resource definitions for EFS and related components.
variables.tf: Input variables for customization.
outputs.tf: Outputs for resource identifiers and metadata.
locals.tf: Computed values for resource efficiency.
Usage;
module "efs" {
  source = "./path-to-module"

  region                        = "us-east-1"
  availability_zone_name        = "us-east-1a"
  subnets                       = ["subnet-123456", "subnet-789012"]
  access_points                 = {
    "user" = {
      creation_info = {
        uid         = 1001
        gid         = 1001
        permissions = "750"
      }
      posix_user = {
        uid = 1001
        gid = 1001
      }
    }
  }
  tags = {
    Environment = "Production"
    Application = "EFS"
  }
}
Inputs
Name	Description	Type	Default	Required
region	AWS Region for the EFS.	string	n/a	yes
availability_zone_name	Availability zone for the EFS.	string	n/a	yes
subnets	List of subnets for EFS mount targets.	list	n/a	yes
access_points	Map of access points with POSIX user and creation info.	map	{}	no
tags	Tags to apply to resources.	map	{}	no
Outputs
Name	Description
efs_id	The ID of the EFS file system.
mount_targets	List of mount target IDs.
dns_name	DNS name for the EFS file system.
