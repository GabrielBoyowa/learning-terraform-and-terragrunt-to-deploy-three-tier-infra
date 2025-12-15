
#---------------------------------------------------------------
# Create the S3 bucket to store the VPC Flow Logs
#---------------------------------------------------------------


resource "aws_s3_bucket" "vpc_flow_logs_bucket" {
  bucket        = var.vpc_flow_logs_bucket
  force_destroy = true

  tags = merge(
    # 1. The map of common tags from your variable
    var.resource_tags,

    # 2. Your specific, hardcoded, or dynamic tags
    {
      Name = "${var.project_name}-marvel-vpc-flow-log-bucket"
    }
  )
}

#---------------------------------------------------------------
# BUCKET POLICY
#---------------------------------------------------------------

resource "aws_s3_bucket_policy" "vpc_flow_logs" {
  bucket = aws_s3_bucket.vpc_flow_logs_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowVPCFlowLogsWrite"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
        Action = "s3:PutObject"
        Resource = [
          aws_s3_bucket.vpc_flow_logs_bucket.arn,
          "${aws_s3_bucket.vpc_flow_logs_bucket.arn}/*"
        ]
      },
      {
        Sid    = "AllowVPCFlowLogsAclCheck"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
        Action   = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.vpc_flow_logs_bucket.arn
      }
    ]
  })
}


#---------------------------------------------------------------
# 3. Create the VPC Flow Log resource
#---------------------------------------------------------------

resource "aws_flow_log" "example_flow_log" {
  vpc_id               = aws_vpc.vpc.id
  log_destination      = aws_s3_bucket.vpc_flow_logs_bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"

  max_aggregation_interval = 60
}



