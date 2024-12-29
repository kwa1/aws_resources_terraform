# Generate an RSA private key
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits  # RSA key size (e.g., 2048, 4096)
}

# Create an EC2 key pair in AWS using the public key
resource "aws_key_pair" "aws_key" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh

  tags = {
    Name        = var.key_name
    Environment = var.environment
  }
}

# Create a Secrets Manager secret to store the private key
resource "aws_secretsmanager_secret" "key_secret" {
  name = var.key_name

  tags = {
    Name        = var.key_name
    Environment = var.environment
  }
}

# Store the private key in Secrets Manager
resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id     = aws_secretsmanager_secret.key_secret.id
  secret_string = tls_private_key.this.private_key_pem
}

# Write the private key to a local .pem file with restricted permissions
resource "local_file" "key_file" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${var.output_dir}/${var.key_name}.pem"
  file_permission = "0400"
}
