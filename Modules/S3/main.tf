
#This is the block of code for creating an S3 Bucket

resource "aws_s3_bucket" "s3-bucket" {
  bucket =  var.s3_bucket_name

  tags = {
    Name = "${var.project_name}-s3-bucket"
  }
}


#FEATURES

resource "aws_s3_bucket_versioning" "versioned_bucket" {
  bucket = aws_s3_bucket.s3-bucket.arn
  versioning_configuration {
    status = "Enabled"
  }
}

