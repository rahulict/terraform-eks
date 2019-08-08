## PROVIDERS ##
provider aws {
  region = "${var.region}"
}

resource aws_kms_key kms_key {
  description = "SSE KMS CMK in ${var.region}"
  is_enabled  = true
}
resource aws_kms_alias kms_alias {
  name          = "alias/kms-${var.region}"
  target_key_id = "${aws_kms_key.kms_key.key_id}"
}
resource "aws_kms_grant" "kms_tf_grants" {
  name              = "kms_tf_grants"
  key_id            = "${aws_kms_key.kms_key.key_id}"
  grantee_principal = "arn:aws:iam::${var.account_number}:user/${var.tf_user}"
  operations        = "${var.tf_user_kms_operations}"
}
