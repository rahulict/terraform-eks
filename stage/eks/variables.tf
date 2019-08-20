variable region {
  default = "ap-south-1"
}

variable "tf_profile" {}

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

