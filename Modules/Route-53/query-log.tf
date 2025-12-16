
#-----------------------------------------------------------------------------
#THIS FILE IS FOR CONFIGURING THE ROUTE 53 DNS LOGS TO S3 BUCKET DESTINATION
#-----------------------------------------------------------------------------


resource "aws_s3_bucket" "dns_query_logs_bucket" {
  bucket        = var.dns_query_logs_bucket
  force_destroy = true

  tags = merge(
    # 1. The map of common tags from your variable
    var.resource_tags,

    # 2. Your specific, hardcoded, or dynamic tags
    {
      Name = "${var.project_name}-valkyrie-query-log-bucket"
    }
  )
}



#------------------------------------------------------------------------------------
#  Add the required bucket policy for DNS QUERY log delivery
#------------------------------------------------------------------------------------

data "aws_iam_policy_document" "dns_query_logs_bucket_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["route53resolver.amazonaws.com"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      aws_s3_bucket.dns_query_logs_bucket.arn,
      "${aws_s3_bucket.dns_query_logs_bucket.arn}/*"
    ]
  }
}


#------------------------------------------------------
# ATTACH POLICY TO BUCKET
#------------------------------------------------------

resource "aws_s3_bucket_policy" "policy-attachment_dns_query_logs" {
  bucket = aws_s3_bucket.dns_query_logs_bucket.id
  policy = data.aws_iam_policy_document.dns_query_logs_bucket_policy.json
}


#----------------------------------------------------------------
# ROUTE 53 RESOLVER QUERY CONFIGURATION
#----------------------------------------------------------------

resource "aws_route53_resolver_query_log_config" "dns_query_logs" {
  name            = var.dns_resolver_query_log_name
  destination_arn = aws_s3_bucket.dns_query_logs_bucket.arn
}


#----------------------------------------------------------------
# ASSOCIATE RESOLVER QUERY LOG WITH VPC
#----------------------------------------------------------------

resource "aws_route53_resolver_query_log_config_association" "vpc_assoc" {
  resolver_query_log_config_id = aws_route53_resolver_query_log_config.dns_query_logs.id
  resource_id                  = var.vpc_id
}




