#Endgame main file containing resources referenced from company module

provider "aws" {
  region  = var.provider_region
  profile = "default"
}

module "vpc" {
  source                         = "../Modules/VPC"
  provider_region                = var.provider_region
  project_name                   = var.project_name
  vpc_cidr_block                 = var.vpc_cidr_block
  public_subnet_1_cidr_block     = var.public_subnet_1_cidr_block
  public_subnet_2_cidr_block     = var.public_subnet_2_cidr_block
  private_subnet_1_cidr_block    = var.private_subnet_1_cidr_block
  private_subnet_2_cidr_block    = var.private_subnet_2_cidr_block
  DB_private_subnet_1_cidr_block = var.DB_private_subnet_1_cidr_block
  DB_private_subnet_2_cidr_block = var.DB_private_subnet_2_cidr_block
}

module "ALB" {
  source                = "../Modules/ALB"
  project_name          = module.vpc.project_name
  alb_security_group_id = module.SECURITY-GROUP.alb_security_group_id
  public_subnet_1_id    = module.vpc.public_subnet_1_id
  public_subnet_2_id    = module.vpc.public_subnet_2_id
  vpc_id                = module.vpc.vpc_id
  aws_instance_id1      = module.EC2.aws_instance_id1
  aws_instance_id2      = module.EC2.aws_instance_id2
}

module "SECURITY-GROUP" {
  source = "../Modules/SECURITY-GROUP"
  vpc_id = module.vpc.vpc_id

}

module "EC2" {
  source                       = "../Modules/EC2"
  project_name                 = module.vpc.project_name
  public_subnet_1_id           = module.vpc.public_subnet_1_id
  public_subnet_2_id           = module.vpc.public_subnet_2_id
  instance_type                = var.instance_type
  key_name                     = var.key_name
  web_server_security_group_id = module.SECURITY-GROUP.web_server_security_group_id
  user_data                    = file(var.user_data)
}
