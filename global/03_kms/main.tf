module kms1 {
  source = "./module"
  region = "${var.kms_regions[0]}"
}
module kms2 {
  source = "./module"
  region = "${var.kms_regions[1]}"
  #region = "ap-southeast-1"
}
