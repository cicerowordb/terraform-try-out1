resource "aws_s3_bucket" "bucket_html" {
  bucket        = var.bucket_name
  acl    = "private"
  versioning {
    enabled = true
  }
  # Changes lifecycle level every 30 days for all file
  lifecycle_rule {
    id      = "all-files"
    enabled = true
    tags = {
      rule      = "all-files"
      autoclean = "true"
    }
    transition {
      days          = 30
      storage_class = "STANDARD_IA" # or "ONEZONE_IA"
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
    expiration {
      days = 90
    }
  }
  # Erases all objects in tmp/ in specified date
  lifecycle_rule {
    id      = "tmp"
    prefix  = "tmp/"
    enabled = true
    expiration {
      date = "2021-12-31"
    }
  }
}
output "aws_s3_bucket_info" {
  value       = aws_s3_bucket.bucket_html.arn
  description = "Bucket ARN"
}