module kms1 {
  source         = "./module"
  region         = "${var.kms_regions[0]}"
  account_number = "${var.account_number}"
}
module kms2 {
  source         = "./module"
  region         = "${var.kms_regions[1]}"
  account_number = "${var.account_number}"
}
