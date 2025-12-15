#Endgame values' file for varibles 

provider_region = "us-east-1"

project_name = "Thanos"

vpc_flow_logs_bucket = "captain-marvel-vpc-flow-logs-bucket-north-virginia"
resource_tags = {
  Environment = "Dev"
  ManagedBy   = "Terraform"
  CostCenter  = "Security"
  Owner       = "InfoSec"
  Repo        = "https://github.com/GabrielBoyowa/learning-terraform-and-terragrunt-to-deploy-three-tier-infra.git"
  Team        = "Avengers"
  Contact     = "erewaboyowa2018@gmail.com"
}
vpc_cidr_block = "10.0.0.0/16"

public_subnet_1_cidr_block = "10.0.0.0/24"

public_subnet_2_cidr_block = "10.0.1.0/24"

private_subnet_1_cidr_block = "10.0.2.0/24"

private_subnet_2_cidr_block = "10.0.3.0/24"

DB_private_subnet_1_cidr_block = "10.0.4.0/24"

DB_private_subnet_2_cidr_block = "10.0.5.0/24"

key_name = "black-panther"

instance_type = "t2.micro"

user_data = "wakanda.sh"

s3_bucket_name = "soul-stone-s3-bucket"

waf_logs_bucket = "aws-waf-logs-unique-black-widow-bucket"
