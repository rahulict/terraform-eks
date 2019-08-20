#!/bin/bash
set -e # Exit on error

if [[ $# -eq 0 ]] || [[ $# -gt 2 ]] || test -n "$2" -a "$2" != "Y" 
then
	echo -e "\n Syntax:\t$0 [plan|apply|destroy] Y"
	echo -e " \t\t2nd argument is optional & can only be Y (denotes -auto-approve)  or blank!!\n"
	exit 1
fi

set -x # Echo everything

#rn:aws:kms:ap-south-1:${TF_VAR_account_number}:kms-ap-south-1
source ../../env.sh
terraform init \
	-backend=true \
	-backend-config="bucket=${TF_VAR_tf_bucket}" \
	-backend-config="key=stage/eks/terraform.tfstate" \
	-backend-config="kms_key_id=${TF_VAR_tf_kms_key_arn}" \
	-backend-config="profile=${TF_VAR_tf_profile}" \
	-backend-config="region=${TF_VAR_region}" \
	-backend-config="encrypt=true"

if test $1 == "plan"
then
	terraform plan
elif test $1 == "apply"
then
	if test -n "$2"
	then
		terraform plan -out ./plan.out
		terraform apply ./plan.out
	else
		terraform apply
	fi
elif test $1 == "destroy"
then
	if test -n "$2"
	then
		terraform destroy --auto-approve
	else
		terraform destroy
	fi
fi
