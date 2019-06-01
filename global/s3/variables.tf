variable region {
  default     = "ap-south-1"
  description = "region to create aws resources"
}
variable tf_bucket {
  default     = "tf-state-key"
  description = "s3 bucket to store tf state files"
}
variable sse_algorithm {
  default     = "AES256"
  description = "server side encryption used by s3 bucket"
}
