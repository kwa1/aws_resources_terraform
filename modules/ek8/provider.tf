provider "aws" {
  region  = var.region
  profile = var.profile
}

provider "aws" {
  alias   = "us"
  region  = var.us_region
  profile = var.profile
}

terraform {
  backend "s3" {
    bucket         = "ek8creation"
    key            = "tf/ek8.tfstate"
    dynamodb_table = "ek8-tf"
    region         = "eu-west-1"
    profile        = "ek8admin"
  }
}
