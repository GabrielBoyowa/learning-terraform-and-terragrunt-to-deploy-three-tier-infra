#This is the variable block for my company module

variable "project_name" {}

variable "resource_tags" {
  type = map(string)
}

variable "s3_bucket_name" {}