
#------------------------------------------------------------------------------------
#THIS FILE IS FOR CONFIGURING THE LOAD BALANCER WAF LOGS TO VARIOUS DESTINATION
#------------------------------------------------------------------------------------


resource "aws_s3_bucket" "waf_logs_bucket" {
  bucket        = var.waf_logs_bucket
  force_destroy = true

  tags = merge(
    # 1. The map of common tags from your variable
    var.resource_tags,

    # 2. Your specific, hardcoded, or dynamic tags
    {
      Name = "${var.project_name}-ALB"
    }
  )
}

#------------------------------------------------------------------------------------
#  Add the required bucket policy for WAF log delivery
#------------------------------------------------------------------------------------
data "aws_iam_policy_document" "waf_logs_bucket_policy" {
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
      aws_s3_bucket.waf_logs_bucket.arn,
      "${aws_s3_bucket.waf_logs_bucket.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "waf_logs_bucket_policy" {
  bucket = aws_s3_bucket.waf_logs_bucket.id
  policy = data.aws_iam_policy_document.waf_logs_bucket_policy.json
}


#----------------------------------
#  WAF LOG DESTINATION 
#----------------------------------


resource "aws_wafv2_web_acl_logging_configuration" "scarlet-waf-logs" {
  resource_arn = aws_wafv2_web_acl.scarlet-witch-WAF.arn

  log_destination_configs = [
    aws_s3_bucket.waf_logs_bucket.arn
  ]
}




