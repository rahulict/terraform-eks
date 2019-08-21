#!/bin/bash
## awscli must be installed ##
export TF_VAR_account_number=$(aws sts get-caller-identity --output text --query Account)
export TF_VAR_region="ap-southeast-1"
#export TF_VAR_tf_bucket="tf-state-key-${TF_VAR_account_number}-${TF_VAR_region}"
#export TF_VAR_tf_bucket="tf-state-key-${TF_VAR_account_number}"
export TF_VAR_tf_dynamodb_table="tf-lock-table-${TF_VAR_account_number}"
export TF_VAR_tf_profile="default"
export TF_VAR_tf_kms_keyid=$(aws kms list-aliases --query $(echo -e "Aliases[?AliasName==\`alias/kms-${TF_VAR_region}\`].TargetKeyId") --region ${TF_VAR_region} --output text)
export TF_VAR_tf_kms_key_arn="arn:aws:kms:${TF_VAR_region}:${TF_VAR_account_number}:key/${TF_VAR_tf_kms_keyid}"
