
#--------------------------------------------------
# Variable file for ROUTE 53 DNS CONFIGURATION 
#--------------------------------------------------

variable "project_name" {}

variable "resource_tags" {
  type = map(string)
}

variable "vpc_id" {
  type = string
}

variable "dns_query_logs_bucket" {}

variable "dns_resolver_query_log_name" {}



