resource "aws_s3_bucket" "bucket_html" {
  bucket        = var.bucket_name
  acl           = "public-read"   # To web access from internet
  force_destroy =  true           # If you want to destroy with files
  # To configure web site
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  # Enable if bucket files are used from other site
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = [
      "https://cicerow.net",
      "http://enterprise.com",
      "https://enterprise.com"
    ]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
  # Enable if you want a log bucket
  # Do not use same bucket, it will not work
  # Use ack = "log-delivery-write" to create log bucket
  # logging {
  #   target_bucket = "log_bucket"
  #   target_prefix = "log/"
  # }
  tags = {
    Environment = "Production"
    Customer    = "Enterprise Contract 2019"
    Billing     = "finance@enterprise.com"
  }
}
output "aws_s3_bucket_info" {
  value       = aws_s3_bucket.bucket_html.arn
  description = "Bucket ARN"
}
