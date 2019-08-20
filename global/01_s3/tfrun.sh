#!/bin/bash
set -e # Exit on error

if [[ $# -eq 0 ]] || [[ $# -gt 2 ]] || test -n "$2" -a "$2" != "Y" 
then
	echo -e "\n Syntax:\t$0 [plan|apply|destroy] Y"
	echo -e " \t\t2nd argument is optional & can only be Y (denotes -auto-approve)  or blank!!\n"
	exit 1
fi

set -x # Echo everything

git pull origin master

source ../../env.sh

if test -e .existing.terraform.tfstate/terraform.tfstate.${TF_VAR_account_number}
then
	if ! cmp --silent .existing.terraform.tfstate/terraform.tfstate.${TF_VAR_account_number} terraform.tfstate
	then
		cp -a .existing.terraform.tfstate/terraform.tfstate.${TF_VAR_account_number} terraform.tfstate
	fi
fi

terraform init

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

if test -e terraform.tfstate
then
	if ! cmp --silent terraform.tfstate .existing.terraform.tfstate/terraform.tfstate.${TF_VAR_account_number}
	then
		cp -a terraform.tfstate .existing.terraform.tfstate/terraform.tfstate.${TF_VAR_account_number}
	fi
fi

git status

set +x && echo && read -p 'Please make sure to run "git push origin master" in case of any change. press ENTER to exit!! '
