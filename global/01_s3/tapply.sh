#!/bin/bash
set -x # Echo everything
set -e # Exit on error

source ../../env.sh

terraform init
terraform plan -out ./plan.out
terraform apply ./plan.out
