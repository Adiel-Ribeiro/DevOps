variable "profile-default" {
  type    = string
  default = "default"
}

variable "virginia" {
  type    = string
  default = "us-east-1"
}

variable "ohio" {
  type    = string
  default = "us-east-2"
}

variable "creds" {
  type    = string
  default = "/nuvym/aws/.cred"
}

variable "aws-cis2-ami" {
  type    = string
  default = "ami-03ff7f1be8da04f52"
}

variable "sg-training" {
  type    = string
  default = "sg-09ac1ad2459effba9"
}

variable "subnet-training" {
  type    = string
  default = "subnet-0dcf22869d0faa3bb"
}

variable "src-file" {
  type    = string
  default = "/nuvym/training/scripts/init.sh"
}

variable "dst" {
  type    = string
  default = "/home/ec2-user/init.sh"
}

variable "training-pem" {
  type    = string
  default = "/nuvym/aws/training.pem"
}

variable "ssh" {
  type    = number
  default = "22"
}

variable "virginia-aza" {
  type    = string
  default = "us-east-1a"
}