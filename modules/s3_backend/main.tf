# modules/s3_bucket/main.tf

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.acl

  versioning {
    enabled = var.versioning_enabled
  }

  lifecycle_rule {
    enabled = true

    expiration {
      days = var.expiration_days
    }
  }

  tags = var.tags
}
