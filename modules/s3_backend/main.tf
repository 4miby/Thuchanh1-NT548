# modules/s3_bucket/main.tf

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.acl

  versioning {
    enabled = var.versioning_enabled
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.sse_algorithm
      }
    }
  }

  lifecycle_rule {
    enabled = true

    expiration {
      days = var.expiration_days
    }
  }

  tags = var.tags
}
