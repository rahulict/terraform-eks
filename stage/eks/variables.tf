variable region {
  default = "ap-south-1"
}

variable "tf_profile" {}

variable "vpc_base_cidr" {
  default = "10.1.0.0/16"
}
variable "public_subnets" {
  type = "string"
  default = "10.1.11.0/24,10.1.12.0/24,10.1.13.0/24"
}
variable "private_subnets" {
  default = "10.1.21.0/24,10.1.22.0/24,10.1.23.0/24"
}
variable "enable_nat_gateway" {
  default = true
}
variable "single_nat_gateway" {
  default = false
}
variable "one_nat_gateway_per_az" {
  default = true
}
variable "enable_vpn_gateway" {
  default = false
}

variable "eks_public_keyname" {
  description = "ssh key pair for EKS worker nodes"
  type        = "string"
  default     = "terraform-eks-key"
}

variable "eks_public_keydata" {
  description = "ssh public key data"
  type        = "string"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/YkZzJGrm/ZEZTMN9eEZ9ofVTDXDeota/6LDI0Btp9mPn7UJCnyz+sZf73uZM6L5NWnqDk0noYls+oYgTsOCsWTa/pbEcjyuYJBrnuhDBfZY6ykrRruv4slrY4O3vnJTlSSz2QrUqXVxx6joKzM6lvtXxqTDQU08bduwZC82gGQ2GzkDwbkb6xZlWRsGj+oryFT2OcIzjJWp2UCf+Y0O14nrwNhF0LeO/8oVZBUF1BFXx2JshEYvwS5Ae/qmmHDBFAqY3UfrpEtrNeuQ77rjM66N57bFtyUe8KGF3TcP26HGOwPYBDK2/gu0q/iD+5w4sKeoYI35R+NN+6VQ2Z56V"
}

variable "environment" {
  default = "staging"
}

variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  default     = "eks"
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  default     = "1.13"
}

variable "manage_aws_auth" {
  description = "Whether to apply the aws-auth configmap file."
  default     = false
}

variable "map_users" {
  description = ""
  type        = "list"
  default = [
    {
      user_arn = "arn:aws:iam::083625559372:user/rahul.kumar"
      username = "rahul.kumar"
      group    = "system:masters"
    },
    {
      user_arn = "arn:aws:iam::083625559372:user/terraform"
      username = "terraform"
      group    = "system:masters"
    },
  ]
}

variable "worker_group_map" {
  description = "worker group map"
  type        = "map"

  default = {
    additional_userdata  = "sudo sed -i 's/nofile=1024:4096/nofile=65536:65536/g' /etc/sysconfig/docker && sudo service docker restart"
    asg_desired_capacity = "3"
    asg_max_size         = 5
    asg_min_size         = 3
    autoscaling_enabled  = true
    instance_type        = "t2.large"
    key_name             = "terraform-eks-key"
  }
}

variable "write_kubeconfig" {
  description = "Option to write kube config file"
  default     = false
}
