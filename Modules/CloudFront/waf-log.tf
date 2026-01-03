


#------------------------------------------------------------------------------------
#THIS FILE IS FOR CONFIGURING THE CLOUD FRONT DISTRIBUTION WAF LOGS TO VARIOUS DESTINATION
#------------------------------------------------------------------------------------


resource "aws_s3_bucket" "aws-waf-logs-CDN-bucket-DESTINATION" {
  bucket        = var.aws-waf-logs-CDN-bucket-DESTINATION
  force_destroy = true

  tags = merge(
    # 1. The map of common tags from your variable
    var.resource_tags,

    # 2. Your specific, hardcoded, or dynamic tags
    {
      Name = "${var.project_name}-cdn-waf-log-destination"
    }
  )
}

#------------------------------------------------------------------------------------
#  Add the required bucket policy for WAF log delivery
#------------------------------------------------------------------------------------

data "aws_iam_policy_document" "cdn-waf_logs_bucket_policy" {
  statement {
    effect = "Allow"
    # The principal is the WAF log delivery service
    principals {
      type        = "Service"
      identifiers = ["waf.amazonaws.com"]
    }
    actions = [
      "s3:PutObject",
      "s3:GetBucketLocation"
    ]
    resources = [
      aws_s3_bucket.aws-waf-logs-CDN-bucket-DESTINATION.arn,
      "${aws_s3_bucket.aws-waf-logs-CDN-bucket-DESTINATION.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "cdn-waf_logs_bucket_policy" {
  bucket = aws_s3_bucket.aws-waf-logs-CDN-bucket-DESTINATION.id
  policy = data.aws_iam_policy_document.cdn-waf_logs_bucket_policy.json
}


#----------------------------------
#  WAF LOG DESTINATION 
#----------------------------------


resource "aws_wafv2_web_acl_logging_configuration" "cdn-waf-logs-destination-configuration" {
  resource_arn = aws_wafv2_web_acl.waf-rule-CDN.arn

  log_destination_configs = [
    aws_s3_bucket.aws-waf-logs-CDN-bucket-DESTINATION.arn
  ]
}




