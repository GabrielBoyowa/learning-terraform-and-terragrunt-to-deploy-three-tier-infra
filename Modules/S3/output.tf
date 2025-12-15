#This is the output file for my s3 bucket module

output "s3_bucket_1_arn" {
  value = aws_s3_bucket.s3-bucket-1.arn
}

output "s3_bucket_2_arn" {
  value = aws_s3_bucket.s3-bucket-2.arn
}

output "resource_tags" {
  value = var.resource_tags
}

