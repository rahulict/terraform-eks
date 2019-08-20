## BACKEND ##
terraform {
  backend "s3" {}
}

## MAIN ##
module kms1 {
  source         = "./module"
  region         = "${var.region}"
  account_number = "${var.account_number}"
  tf_profile     = "${var.tf_profile}"
}
module kms2 {
  source         = "./module"
  region         = "${var.kms_other_region}"
  account_number = "${var.account_number}"
  tf_profile     = "${var.tf_profile}"
}

## OUTPUT ##
output aws_kms_key_1_arn {
  value = "${module.kms1.aws_kms_key_arn}"
}
output aws_kms_key_2_arn {
  value = "${module.kms2.aws_kms_key_arn}"
}
