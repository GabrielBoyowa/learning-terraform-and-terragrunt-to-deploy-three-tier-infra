
#This is the block of code for creating TWO S3 Buckets

resource "aws_s3_bucket" "s3-bucket-1" {
  bucket        = "${var.s3_bucket_name}-1"
  force_destroy = true



  tags = merge(
    # 1. The map of common tags from your variable
    var.resource_tags,

    # 2. Your specific, hardcoded, or dynamic tags
    {
      Name = "${var.project_name}-s3-bucket-1"
    }
  )
}


##BUCKET VERSIONING 
resource "aws_s3_bucket_versioning" "versioned_bucket_1" {
  bucket = aws_s3_bucket.s3-bucket-1.id
  versioning_configuration {
    status = "Enabled"
  }
}





resource "aws_s3_bucket" "s3-bucket-2" {
  bucket        = "${var.s3_bucket_name}-2"
  force_destroy = true

  tags = merge(
    # 1. The map of common tags from your variable
    var.resource_tags,

    # 2. Your specific, hardcoded, or dynamic tags
    {
      Name = "${var.project_name}-s3-bucket-1"
    }
  )
}

##BUCKET VERSIONING 
resource "aws_s3_bucket_versioning" "versioned_bucket_2" {
  bucket = aws_s3_bucket.s3-bucket-2.id
  versioning_configuration {
    status = "Enabled"
  }
}



