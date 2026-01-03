
#---------------------------------------------
# CLOUD FRONT DISTRIBUTION
#---------------------------------------------

resource "aws_cloudfront_distribution" "cdn_distribution" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name              = aws_s3_bucket.cloud_front_origin_bucket.bucket_regional_domain_name
    origin_id                = "s3-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "s3-origin"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  #is_ipv6_enabled = false

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}



