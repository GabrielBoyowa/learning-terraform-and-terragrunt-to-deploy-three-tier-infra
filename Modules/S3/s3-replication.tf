

# IAM Role for Replication
resource "aws_iam_role" "replication_role" {
  name = "s3-replication-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "s3.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# IAM Policy for Replication
resource "aws_iam_policy" "replication_policy" {
  name        = "s3-replication-policy"
  description = "Allows S3 replication between primary and secondary buckets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ReplicateObject", "s3:ReplicateDelete", "s3:GetObjectVersion", "s3:GetObjectVersionAcl"]
        Resource = "arn:aws:s3:::${aws_s3_bucket.s3-bucket-1.bucket}/*"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:ReplicateObject", "s3:ReplicateDelete"]
        Resource = "arn:aws:s3:::${aws_s3_bucket.s3-bucket-2.bucket}/*"
      }
    ]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "replication_policy_attach" {
  role       = aws_iam_role.replication_role.name
  policy_arn = aws_iam_policy.replication_policy.arn
}

# S3 Replication Configuration
resource "aws_s3_bucket_replication_configuration" "replication" {
  bucket   = aws_s3_bucket.s3-bucket-1.id
  role     = aws_iam_role.replication_role.arn

  rule {
    id     = "same-region-replication"
    status = "Enabled"

    filter {
      prefix = "" # Replicate all objects or *.pdf *.mp4
    }

    destination {
      bucket        = aws_s3_bucket.s3-bucket-2.arn
      storage_class = "STANDARD"
    }
    delete_marker_replication {
      status = "Enabled"
    }
  }
}