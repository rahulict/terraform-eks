#!/bin/bash
set -x # Echo everything
set -e # Exit on error

source ../../env.sh

terraform init \
	-backend=true \
	-backend-config="bucket=${TF_VAR_tf_bucket}" \
	-backend-config="key=global/dynamodb/terraform.tfstate" \
	-backend-config="region=${TF_VAR_region}"

terraform plan -out ./plan.out
terraform apply ./plan.out
