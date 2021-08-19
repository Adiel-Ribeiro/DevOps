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

variable "aws-ami-virginia" {
  type    = string
  default = "ami-0c2b8ca1dad447f8a"
}

variable "aws-ami-ohio" {
  type    = string
  default = "ami-0443305dabd4be2bc"
}

variable "virginia-1a-sg" {
  type    = string
  default = "virginia-sg"
}

variable "virginia-1a-subnet" {
  type    = string
  default = "subnet_1"
}

variable "virginia-1b-sg" {
  type    = string
  default = "virginia-1b-sg"
}

variable "virginia-1b-subnet" {
  type    = string
  default = "subnet_2"
}

variable "virginia-azb" {
  type    = string
  default = "us-east-1b"
}

variable "ohio-sg" {
  type    = string
  default = "ohio-sg"
}

variable "ohio-subnet" {
  type    = string
  default = "subnet_1-ohio"
}

variable "ohio-aza" {
  type    = string
  default = "us-east-2a"
}