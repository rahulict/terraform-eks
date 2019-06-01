terraform {
  backend s3 {
    bucket = "tf-state-key"
    key    = "global/dynamodb/terraform.tfstate"
    region = "ap-south-1"
  }
}
