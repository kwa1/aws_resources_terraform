Features
Encrypted by Default: Ensures the EBS volume is always encrypted using AWS-managed or customer-managed KMS keys.
Flexible Attachment: Allows conditional attachment to EC2 instances or standalone usage.
Dynamic Configuration: Automatically adjusts IOPS and throughput based on the volume type.
Tagging: Includes mandatory Name tag and supports custom tags.
Multi-Attach Support: Optionally enables Multi-Attach for specific use cases.
Usage
Example
hcl
Copy code
module "ebs_volume" {
  source              = "./modules/ebs"
  availability_zone   = "us-east-1a"
  volume_size         = 30
  volume_type         = "gp3"
  kms_key_id          = "arn:aws:kms:us-east-1:123456789012:key/your-kms-key-id"
  instances           = ["i-0123456789abcdef0", "i-0fedcba9876543210"]
  attach_to_instance  = true
  tags = {
    Environment = "Production"
    Team        = "DevOps"
  }
}
Variables
Name	Type	Default	Description
availability_zone	string	-	The AZ where the EBS volume will be created.
volume_size	number	20	The size of the EBS volume in GiB.
volume_type	string	"gp3"	The type of EBS volume (gp2, gp3, io1, io2, sc1, st1).
kms_key_id	string	null	KMS Key ID for encryption. Defaults to AWS managed key if not specified.
name	string	"ebs-volume"	Name of the EBS volume for tagging purposes.
iops	number	null	The number of IOPS for io1, io2, or gp3 volumes.
throughput	number	null	Throughput in MiB/s for gp3 volumes.
multi_attach_enabled	bool	false	Enable Multi-Attach support for the volume.
device_name	string	"/dev/xvdf"	The device name for the volume (e.g., /dev/xvdf).
instances	list(string)	[]	List of instance IDs to attach the volume to.
attach_to_instance	bool	false	Whether to attach the volume to instances or not.
force_detach	bool	false	Force detachment of the volume during an update if it is attached.
tags	map(string)	{}	Tags to apply to resources.
Outputs
Name	Description
ebs_volume_id	The ID of the EBS volume.
attached_instances	List of instances the volume is attached to.
Module Structure
python
Copy code
modules/
└── ebs/
    ├── main.tf       # Resource definitions
    ├── variables.tf  # Input variables
    ├── locals.tf     # Local variables and defaults
    ├── outputs.tf    # Outputs for the module
Requirements
Terraform Version: 1.0.0 or higher
AWS Provider: 4.x or higher
Best Practices
Use AWS Key Management Service (KMS) for custom encryption.
Avoid enabling multi_attach_enabled unless required for advanced use cases.
Ensure appropriate IAM permissions for creating and managing EBS volumes.
License
This module is licensed under the MIT License. See the LICENSE file for details.

