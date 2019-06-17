#!/bin/bash
## awscli must be installed ##
export TF_VAR_account_number=$(aws sts get-caller-identity --output text --query Account)
export TF_VAR_region="ap-southeast-1"
export TF_VAR_tf_bucket="tf-state-key-${TF_VAR_account_number}"
export TF_VAR_tf_dynamodb_table="tf-lock-table-${TF_VAR_account_number}"
