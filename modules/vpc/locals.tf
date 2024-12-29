locals {
  tags = merge(
    {
      Environment = "production"
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}
