output aws_kms_key_1_arn {
  value = "${module.kms1.aws_kms_key_arn}"
}
output aws_kms_key_2_arn {
  value = "${module.kms2.aws_kms_key_arn}"
}
