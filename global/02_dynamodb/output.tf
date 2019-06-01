output dynamodb_arn {
  value = "${aws_dynamodb_table.tf-lock-table.arn}"
}
