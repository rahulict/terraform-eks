## PROVIDERS ##
provider aws {
  region  = "${var.region}"
  profile = "${var.tf_profile}"
}

data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid    = "EnableIAMUserPermissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_number}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
  statement {
    sid    = "AllowAccessForKeyAdministrators"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_number}:user/${var.tf_user}"]
    }
    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowUseOfTheKey"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_number}:user/${var.tf_user}"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = ["*"]
  }
}
resource aws_kms_key kms_key {
  description = "SSE KMS CMK in ${var.region}"
  is_enabled  = true
  policy      = "${data.aws_iam_policy_document.kms_policy.json}"
}
resource aws_kms_alias kms_alias {
  name          = "alias/kms-${var.region}"
  target_key_id = "${aws_kms_key.kms_key.key_id}"
}
