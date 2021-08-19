terraform {
  required_version = ">=0.14.5"
  backend "s3" {
    region  = "us-east-1"
    profile = "default"
    key     = "tfstate-aws-19-08-21-us-east-1"
    bucket  = "nuvym-terraform"
  }
}
