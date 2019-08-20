## BACKEND ##
terraform {
 backend s3 {}
}

## PROVIDERS ##
provider aws {
  region  = "${var.region}"
  profile = "${var.tf_profile}"
}

## MAIN ##
resource aws_key_pair cluster_key {
  key_name   = "${var.eks_public_keyname}"
  public_key = "${var.eks_public_keydata}"
}
