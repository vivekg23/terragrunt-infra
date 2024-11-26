/*
# Create S3 buckets with versioning enabled
resource "aws_s3_bucket" "buckets" {
  for_each = toset(var.bucket_names)
  bucket = each.key

  versioning {
    enabled = true
  }
}
*/

# Create S3 buckets with versioning enabled
resource "aws_s3_bucket" "buckets" {
  for_each = toset(["rbx-annotations-${var.env}","rbx-assemblies-${var.env}","rbx-patch-logs-${var.env}","rbx-references-${var.env}","rbx-samples-${var.env}","rbx-scratch-${var.env}","rbx-verifications-${var.env}"]) # Add your bucket names here
  bucket = each.key

  versioning {
    enabled = true
  }
}

# Bucket policy for every bucket
resource "aws_s3_bucket_policy" "bucket_policy" {
  for_each = toset(["rbx-annotations-${var.env}","rbx-assemblies-${var.env}","rbx-patch-logs-${var.env}","rbx-references-${var.env}","rbx-samples-${var.env}","rbx-scratch-${var.env}","rbx-verifications-${var.env}"]) # Add your bucket names here

  bucket = aws_s3_bucket.buckets[each.key].bucket
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CrossAccountReadOnly",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${var.cross_account_arn}"
            },
            "Action": [
                "s3:ListBucket",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${each.key}",
                "arn:aws:s3:::${each.key}/*"
             ]
        }
     ]
})
}