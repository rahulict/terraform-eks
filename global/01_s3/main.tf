resource aws_s3_bucket tf-state-key {
  bucket = "${var.tf_bucket}-${data.aws_caller_identity.current.account_id}"
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
  lifecycle {
    prevent_destroy = true
  }
}
