


module "vpc" {
  source = "./vpc-module"
}

module "rds_mysql" {
  source = "./rds-mysql-module"

  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  username               = "admin"
  password               = "securepassword"
  vpc_security_group_ids = [module.vpc.default_sg]
  subnet_ids             = module.vpc.private_subnets
  tags                   = { Environment = "Production" }
}

module "aurora" {
  source = "./aurora-cluster-module"

  cluster_name           = "my-aurora-cluster"
  username               = "admin"
  password               = "securepassword"
  vpc_security_group_ids = [module.vpc.default_sg]
  subnet_ids             = module.vpc.private_subnets
  tags                   = { Environment = "Production" }
}
