# You can reference this module in your root module like so:

module "vpc" {
  source = "./vpc-module"
}

module "postgres_rds" {
  source = "./postgres-rds-module"

  db_name                = "my-postgres-db"
  engine_version         = "13.4"
  instance_class         = "db.t3.micro"
  allocated_storage      = 50
  username               = "admin"
  password               = "securepassword"
  vpc_security_group_ids = [module.vpc.default_sg]
  subnet_ids             = module.vpc.private_subnets
  multi_az               = true
  tags                   = { Application = "MyApp", Environment = "Production" }
}
