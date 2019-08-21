## BACKEND ##
terraform {
  backend s3 {}
}

## PROVIDERS ##
provider aws {
  region  = "${var.region}"
  profile = "${var.tf_profile}"
}

## LOCALS ##
locals {
  name = "${var.cluster_name}-${var.environment}"
  common_tags = {
    Name        = "${local.name}"
    Terraform   = "true"
    Environment = "${var.environment}"
  }
  eks_private_subnet_count = 3
  subnet_shared_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  worker_group_map = {
    subnets = "${join(",", module.vpc.private_subnets)}"
  }
}

## Data ##
data "aws_availability_zones" "available" {}

## MAIN ##
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "${local.name}"
  cidr   = "${var.vpc_base_cidr}"
  # NAT Gateway configuration
  azs                    = "${data.aws_availability_zones.available.names}"
  enable_nat_gateway     = "${var.enable_nat_gateway}"
  single_nat_gateway     = "${var.single_nat_gateway}"
  one_nat_gateway_per_az = "${var.one_nat_gateway_per_az}"
  # Subnet Configuration
  public_subnets      = split(",", "${var.public_subnets}")
  private_subnets     = split(",", "${var.private_subnets}")
  public_subnet_tags  = "${merge(local.common_tags, local.subnet_shared_tags)}"
  private_subnet_tags = "${merge(local.common_tags, local.subnet_shared_tags)}"
  tags                = "${local.common_tags}"
}

resource aws_key_pair cluster_key {
  key_name   = "${var.eks_public_keyname}"
  public_key = "${var.eks_public_keydata}"
}

#module eks {
#  source           = "terraform-aws-modules/eks/aws"
#  cluster_name     = "${local.common_tags.Name}"
#  cluster_version  = "${var.cluster_version}"
#  manage_aws_auth  = "${var.manage_aws_auth}"
#  map_users        = ["${var.map_users}"]
#  subnets          = ["${module.vpc.private_subnets}", "${module.vpc.public_subnets}"]
#  tags             = "${local.common_tags}"
#  vpc_id           = "${module.vpc.vpc_id}"
#  worker_groups    = ["${merge(var.worker_group_map, local.worker_group_map)}"]
#  write_kubeconfig = "${var.write_kubeconfig}"
#}
