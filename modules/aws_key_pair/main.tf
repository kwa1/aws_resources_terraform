resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "aws_key" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}

resource "aws_secretsmanager_secret" "key_secret" {
  name = var.key_name
}

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id = aws_secretsmanager_secret.key_secret.id
  secret_string = tls_private_key.this.private_key_pem
}

resource "local_file" "key_file" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${path.cwd}/${var.key_name}.pem"
  file_permission = "0400"
}
