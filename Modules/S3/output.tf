#This is the output file for my company s3 bucket module

output "s3_bucket_arn" {
  value = aws_s3_bucket.s3-bucket.arn
}