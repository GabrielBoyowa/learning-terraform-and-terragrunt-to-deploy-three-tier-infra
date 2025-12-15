
#---------------------------------------------------------------
#Endgame variables file 
#---------------------------------------------------------------

variable "provider_region" {}

variable "project_name" {}

variable "vpc_flow_logs_bucket" {}
variable "resource_tags" {
  type = map(string)
}

variable "vpc_cidr_block" {}

variable "public_subnet_1_cidr_block" {}

variable "public_subnet_2_cidr_block" {}

variable "private_subnet_1_cidr_block" {}

variable "private_subnet_2_cidr_block" {}

variable "DB_private_subnet_1_cidr_block" {}

variable "DB_private_subnet_2_cidr_block" {}

variable "key_name" {}

variable "instance_type" {}

variable "user_data" {}

variable "s3_bucket_name" {}

variable "waf_logs_bucket" {}

