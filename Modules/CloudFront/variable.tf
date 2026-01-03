
#------------------------------------------
# VARIABLE FILE FOR CLOUD FRONT
#------------------------------------------

variable "resource_tags" {
  type = map(string)
}

variable "project_name" {}

variable "aws-waf-logs-CDN-bucket-DESTINATION" {}

variable "cloud_front_origin_bucket" {}
