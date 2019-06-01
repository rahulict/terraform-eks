resource aws_kms_key kms_key {
	description = "SSE KMS CMK in ${var.region}"
	is_enabled = true
}
resource aws_kms_alias kms_alias {
	name = "alias/kms-${var.region}"
	target_key_id = "${aws_kms_key.kms_key.key_id}"
}
