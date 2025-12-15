#This is the variable block for my company module

variable "project_name" {}

variable "provider_region" {}

variable "waf_logs_bucket" {}
variable "resource_tags" {
  type = map(string)
}
variable "alb_security_group_id" {}

variable "public_subnet_1_id" {}

variable "public_subnet_2_id" {}

variable "vpc_id" {}

variable "aws_instance_id1" {}

variable "aws_instance_id2" {}

variable "s3_bucket_1_arn" {}


