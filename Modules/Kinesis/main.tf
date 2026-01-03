# #-----------------------------
# # IAM Role for Kinesis Firehose
# #-----------------------------
# resource "aws_iam_role" "kinesis_firehose" {
#   name = "${var.project_name}-firehose-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "firehose.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy" "firehose_policy" {
#   name = "${var.project_name}-firehose-policy"
#   role = aws_iam_role.kinesis_firehose.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "s3:PutObject",
#           "s3:GetBucketLocation"
#         ]
#         Resource = "${var.alb_log_bucket_arn}/*"
#       }
#     ]
#   })
# }


# # Kinesis Firehose Delivery Stream
# resource "aws_kinesis_firehose_delivery_stream" "hulk_delivery_stream" {
#   name        = var.kinesis_stream_name
#   destination = "extended_s3"

#   extended_s3_configuration {
#     role_arn   = aws_iam_role.kinesis_firehose.arn
#     bucket_arn = var.alb_log_bucket_arn
#     # buffer options go under the nested configuration block
#     buffering_interval = 60
#     buffering_size     = 5
#   }
#   tags = merge(
#     var.resource_tags,
#     {
#       Name = "${var.project_name}-hulk-kinesis-firehose-virginia"
#     }
#   )
# }
