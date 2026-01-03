#--------------------------------------------------------------------
# APPLICATION LOAD BALANCER ACCESS LOGS DESTINATION
#--------------------------------------------------------------------

#-----------------------------------------------
# Create an S3 bucket for ALB access logs
#-----------------------------------------------
resource "aws_s3_bucket" "alb_log_bucket" {
  bucket        = var.alb_log_bucket
  force_destroy = true

  tags = merge(
    # 1. The map of common tags from your variable
    var.resource_tags,

    # 2. Your specific, hardcoded, or dynamic tags
    {
      Name = "${var.project_name}-load-balancer-log-bucket"
    }
  )
}

#-------------------------------------------------------------------------------------
# Attach a specific policy to the S3 bucket, allowing the ALB service to write logs
#-------------------------------------------------------------------------------------
data "aws_iam_policy_document" "alb_log_bucket_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::127311923021:root"]
    }

    actions = ["s3:PutObject"]

    resources = [
      "${aws_s3_bucket.alb_log_bucket.arn}/AWSLogs/188735152537/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "alb-log-bucket-policy" {
  bucket = aws_s3_bucket.alb_log_bucket.id
  policy = data.aws_iam_policy_document.alb_log_bucket_policy.json

  depends_on = [
    aws_s3_bucket.alb_log_bucket
  ]
}