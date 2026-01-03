
#----------------------------------------------------
# CLOUD FRONT ORIGIN BUCKET FOR CLOUD FRONT
#----------------------------------------------------

resource "aws_s3_bucket" "cloud_front_origin_bucket" {
  bucket        = var.cloud_front_origin_bucket
  force_destroy = true


  tags = merge(
    # 1. The map of common tags from your variable
    var.resource_tags,

    # 2. Your specific, hardcoded, or dynamic tags
    {
      Name = "${var.project_name}-cloud-front-origin-static-bucket"
    }
  )
}

#-----------------------------
##  BUCKET VERSIONING 
#-----------------------------

resource "aws_s3_bucket_versioning" "cloud_front_origin_versioned_bucket" {
  bucket = aws_s3_bucket.cloud_front_origin_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}



resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.cloud_front_origin_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


#---------------------------------------------
# ORIGIN ACCESS CONTROL CONFIGURATION
#---------------------------------------------

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.project_name}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

#----------------------------------------------
# BUCKET POLICY TO ALLOW CLOUD FRONT
#--------------------------------------------------

data "aws_iam_policy_document" "cloudfront_access" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.cloud_front_origin_bucket.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.cdn_distribution.arn]
    }
  }
}


#---------------------------------------------
# ATTACH POLICY TO BUCKET
#---------------------------------------------

resource "aws_s3_bucket_policy" "cloudfront_access" {
  bucket = aws_s3_bucket.cloud_front_origin_bucket.id
  policy = data.aws_iam_policy_document.cloudfront_access.json
}


#---------------------------------------------
# UPLOAD HTML FILE TO S3 BUCKET
#---------------------------------------------

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.cloud_front_origin_bucket.id
  key          = "index.html"
  source       = "../Modules/CloudFront/index.html" #"${path.module}/site/index.html"  # relative path to your HTML file
  content_type = "text/html"
}
