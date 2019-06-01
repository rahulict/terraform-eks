variable region {
  default = "ap-south-1"
}

## Used in global/s3 ##
variable tf_bucket {
  default     = "tf-state-key"
  description = "s3 bucket to store tf state files"
}
variable sse_algorithm {
  default     = "AES256"
  description = "server side encryption used by s3 bucket"
}
variable kms_regions {
  description = "defines region in which to create kms keys"
  type        = "list"
  default     = ["ap-south-1", "ap-southeast-1"]
}
variable tf_user {
  description = "User which connect to aws"
  default     = "terraform"
}
variable tf_user_kms_operations {
  description = "kms permission to terraform user"
  type        = "list"
  default = [
    "Decrypt",
    "Encrypt",
    "GenerateDataKey",
    "GenerateDataKeyWithoutPlaintext",
    "ReEncryptFrom",
    "ReEncryptTo",
    "CreateGrant",
    "RetireGrant",
    "DescribeKey"
  ]
}
