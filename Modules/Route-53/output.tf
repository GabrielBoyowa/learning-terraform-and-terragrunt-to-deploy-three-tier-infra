
#-----------------------------------------
# OUTPUT FILE FOR ROUTE 53 CONFIGURATION
#-----------------------------------------

output "dns_query_logs_bucket" {
  value = aws_s3_bucket.dns_query_logs_bucket.arn
}

