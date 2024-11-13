# modules/s3_bucket/variables.tf

variable "bucket_name" {
  description = "bucket name"
  type        = string
}

variable "acl" {
  description = "acl"
  type        = string
  default     = "private"
}

variable "versioning_enabled" {
  description = "versioning option"
  type        = bool
  default     = true
}

variable "expiration_days" {
  description = ""
  type        = number
  default     = 365
}

variable "tags" {
  description = ""
  type        = map(string)
  default     = {}
}
