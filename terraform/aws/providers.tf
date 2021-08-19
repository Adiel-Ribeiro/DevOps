provider "aws" {
  profile                 = var.profile-default
  region                  = var.virginia
  alias                   = "virginia"
  shared_credentials_file = var.creds
}

provider "aws" {
  profile                 = var.profile-default
  region                  = var.ohio
  alias                   = "ohio"
  shared_credentials_file = var.creds
}

