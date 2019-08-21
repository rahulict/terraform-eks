## PROVIDERS ##
provider aws {
  region  = "${var.region}"
  profile = "${var.tf_profile}"
}

## MAIN ##
resource aws_s3_bucket tf-state-key {
  bucket = "${var.tf_bucket}"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "${var.sse_algorithm}"
      }
    }
  }
#  lifecycle {
#    prevent_destroy = true
#  }
}

## OUTPUTS ##
output terraform_bucket_name {
  value = "${aws_s3_bucket.tf-state-key.bucket}"
}
