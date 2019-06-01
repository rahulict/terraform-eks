resource aws_dynamodb_table "tf-lock-table" {
  name     = "tf-lock-table"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  read_capacity  = 5
  write_capacity = 5
}
