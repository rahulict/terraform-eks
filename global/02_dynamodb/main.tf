## BACKEND ##
terraform {
  backend "s3" {}
}

## PROVIDERS ##
provider aws {
  region  = "${var.region}"
  profile = "${var.tf_profile}"
}

## MAIN ##
resource aws_dynamodb_table "tf-lock-table" {
  name     = "tf-lock-table-${var.account_number}"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  read_capacity  = 5
  write_capacity = 5
}

## OUTPUT ##
output dynamodb_arn {
  value = "${aws_dynamodb_table.tf-lock-table.arn}"
}
