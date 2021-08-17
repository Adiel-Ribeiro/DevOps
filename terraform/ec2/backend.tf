terraform {
  required_version = ">=0.14.5"
  backend "s3" {
    region  = "us-east-1"
    profile = "default"
    key     = "tfstate-ec2-us-east-1"
    bucket  = "nuvym-terraform"
  }
}
