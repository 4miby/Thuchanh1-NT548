# modules/s3_bucket/outputs.tf

output "bucket_name" {
  description = "s3 bucket name"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "s3 bucket arn"
  value       = aws_s3_bucket.this.arn
}
