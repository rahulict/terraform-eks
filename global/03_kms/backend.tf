terraform {
  backend s3 {
    bucket         = "tf-state-key"
    key            = "global/kms/terraform.tfstate"
    dynamodb_table = "tf-lock-table"
    region         = "ap-south-1"
  }
}
