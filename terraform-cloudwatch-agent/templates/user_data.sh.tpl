#!/bin/bash
set -e

# Update the system and install the CloudWatch Agent
yum update -y
yum install -y amazon-cloudwatch-agent

# Create the configuration directory
mkdir -p /opt/aws/amazon-cloudwatch-agent/etc/

# Check the source of the configuration
if [ "${cw_agent_config_source}" = "s3" ]; then
  echo "Fetching CloudWatch Agent config from S3..."

  # Download the CloudWatch Agent configuration from S3
  aws s3 cp s3://${s3_bucket}/${s3_key} /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json >> /var/log/user-data.log 2>&1

  # Verify the download was successful
  if [ -f /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json ]; then
    echo "CloudWatch Agent config downloaded successfully from S3." >> /var/log/user-data.log 2>&1
  else
    echo "Failed to download CloudWatch Agent config from S3." >> /var/log/user-data.log 2>&1
    exit 1
  fi

else
  echo "Using local CloudWatch Agent config..."

  # Use the local configuration file
  cp ${local_path} /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

  # Verify the copy was successful
  if [ -f /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json ]; then
    echo "CloudWatch Agent config copied successfully from local path." >> /var/log/user-data.log 2>&1
  else
    echo "Failed to copy CloudWatch Agent config from local path." >> /var/log/user-data.log 2>&1
    exit 1
  fi
fi

# Start the CloudWatch Agent
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a start -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json >> /var/log/user-data.log 2>&1

# Enable the CloudWatch Agent on boot
systemctl enable amazon-cloudwatch-agent >> /var/log/user-data.log 2>&1
