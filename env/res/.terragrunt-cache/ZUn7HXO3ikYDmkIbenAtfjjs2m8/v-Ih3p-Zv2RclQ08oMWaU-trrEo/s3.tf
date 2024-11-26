# Create S3 buckets with versioning enabled
resource "aws_s3_bucket" "buckets" {
  for_each = toset(var.bucket_names)
  bucket = each.key

  versioning {
    enabled = true
  }
}