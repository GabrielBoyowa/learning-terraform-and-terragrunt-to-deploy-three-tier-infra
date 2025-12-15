
#---------------------------------------------------------------
# This connects the lifecycle policy to bucket-1
#---------------------------------------------------------------
resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle_config" {
  bucket = aws_s3_bucket.s3-bucket-1.id

  # The configuration contains the following rules
  rule {
    id     = "ArchivalPolicy"
    status = "Enabled"

    #---------------------------------------------------------------
    # --- Rules for Current Object Version ---
    #---------------------------------------------------------------

    # Rule 1: Transition to Infrequent Access (IA) after 30 days
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    # Rule 2: Transition to Glacier after 90 days
    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    # Rule 3: Transition to Glacier Deep Archive after 180 days
    transition {
      days          = 180
      storage_class = "DEEP_ARCHIVE"
    }

    #---------------------------------------------------------------
    # --- Rules for Noncurrent Object Versions (Duplicate of Current Rules) ---
    #---------------------------------------------------------------

    # Noncurrent Rule 1: Transition to Infrequent Access (IA) after 30 days
    # (after becoming noncurrent)
    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }

    # Noncurrent Rule 2: Transition to Glacier after 90 days
    # (after becoming noncurrent)
    noncurrent_version_transition {
      noncurrent_days = 90
      storage_class   = "GLACIER"
    }

    # Noncurrent Rule 3: Transition to Glacier Deep Archive after 180 days
    # (after becoming noncurrent)
    noncurrent_version_transition {
      noncurrent_days = 180
      storage_class   = "DEEP_ARCHIVE"
    }

  }
}