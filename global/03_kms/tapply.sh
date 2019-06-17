#!/bin/bash
set -x # Echo everything
set -e # Exit on error

source ../../env.sh

terraform init \
	-backend=true \
	-backend-config="bucket=${TF_VAR_tf_bucket}" \
	-backend-config="key=global/kms/terraform.tfstate" \
	-backend-config="dynamodb_table=${TF_VAR_tf_dynamodb_table}" \
	-backend-config="region=${TF_VAR_region}"

terraform plan -out ./plan.out
terraform apply ./plan.out
